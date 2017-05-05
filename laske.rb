#encoding:utf-8
require 'csv'
require 'byebug'
require 'json'

# Get data from maakuntajakolaki
require_relative 'mappings.rb'

# Load data
rows = CSV.read('candidates.csv', {:encoding => 'ISO-8859-1:utf-8', :col_sep => ';'})

# Settings
mapping = MAPPING_MAAKUNTAVAALIT
positionsPerDistrict = POSITIONS_MAAKUNTAVAALIT

# Set up main data, get districts from mapping
mainData = Hash.new
mapping.each do |district|
  mainData[district[1]] = {"district" => district[1], "candidates" => [], "partyVotes" => Hash.new(0)}
end

# Set up result data
resultData = Hash.new
resultData["seats"] = Hash.new(0)
resultData["seats"]["totals"] = Hash.new(0)
resultData["hometowns"] = Hash.new(0)

# Load data to districts
rows.each do |row|
  district = mapping[row[7]]

  mainData[district]["candidates"].push({"Etunimi"=>row[0],"Sukunimi"=>row[2],"Puolue"=>row[3], "Kotikunta"=>row[7], "Äänimäärä" => row[11].to_i, "Sijoitus" => 0, "Vertailuluku" => 0.0, "Valittiinko" => "Ei"})
  mainData[district]["partyVotes"][row[3]] += row[11].to_i

end


## Calculate position in party list

# First we sort the candidates lists according to vote count in descending order

mainData.each do |district|
  mainData[district[1]["district"]]["candidates"] = district[1]["candidates"].sort_by { |candidate|
  -candidate["Äänimäärä"] }
end

# Then we give the candidates a placing in ther respective list

mainData.each do |district|
  partyStanding = Hash.new(0)
  mainData[district[1]["district"]]["candidates"].each_with_index do |candidate, index|
    partyStanding[candidate["Puolue"]] += 1
    mainData[district[1]["district"]]["candidates"][index]["Sijoitus"] = partyStanding[candidate["Puolue"]]
  end
end

# Then we calculate the vertailuluku

mainData.each do |district|

  districtInLoop = district[1]["district"]

  # Prepare the result data, fill it with districts
  resultData["hometowns"][districtInLoop] = Hash.new(0)
  resultData["seats"][districtInLoop] = Hash.new(0)

  mainData[districtInLoop]["candidates"].each_with_index do |candidate, index|

    # Calculate the vertailuluku
    mainData[districtInLoop]["candidates"][index]["Vertailuluku"] = mainData[districtInLoop]["partyVotes"][candidate["Puolue"]] / candidate["Sijoitus"]

    # Push all cities to data so we can see zeroes in results
    resultData["hometowns"][districtInLoop][candidate["Kotikunta"]] = 0

  end
end

## Calculate positions

# First we sort the candidates lists according to vertailuluku in descending order

mainData.each do |district|
  mainData[district[1]["district"]]["candidates"] = district[1]["candidates"].sort_by { |candidate|
  -candidate["Vertailuluku"] }
end


## Then we calculate the positions per party according to seats per district
## And we calculate the hometowns of selected

mainData.each do |district|

  # Calculate the total number of districts in calculation
  resultData["seats"]["totals"]["Districts"] += 1

  # Prepare the candidate loop
  seatsPerDistrict = positionsPerDistrict[district[0]]-1 # 0 to max-1
  districtInLoop = district[1]["district"]

  # Loop all candidates who are selected in district
  mainData[districtInLoop]["candidates"][0..seatsPerDistrict].each_with_index do |candidate, index|
    # Add elected status to data
    mainData[districtInLoop]["candidates"][index]["Valittiinko"] = "Kyllä"

    # Calculate party standings and home towns
    resultData["seats"][districtInLoop][candidate["Puolue"]] += 1
    resultData["seats"][districtInLoop]["Totalseats"] += 1
    resultData["seats"]["totals"]["Totalseats"] += 1
    resultData["seats"]["totals"][candidate["Puolue"]] += 1
    resultData["hometowns"][districtInLoop][candidate["Kotikunta"]] += 1
    resultData["hometowns"][districtInLoop]["Totalseats"] += 1

  end
end
### CALCULATIONS DONE, WRITE RESULTS TO FILE

## Write the candidate data to files

CSV.open( "candidateresults.csv", 'w' ) do |writeline|

  mainData.each do |district|

    writeline << ["Äänestysalue", "Etunimi", "Sukunimi", "Puolue", "Kotikunta", "Valittiinko", "Äänimäärä", "Vertailuluku", "Sijoitus listalla"]

    mainData[district[1]["district"]]["candidates"].each do |candidate|
      writeline << [district[0], candidate["Etunimi"], candidate["Sukunimi"], candidate["Puolue"], candidate["Kotikunta"], candidate["Valittiinko"], candidate["Äänimäärä"], candidate["Vertailuluku"], candidate["Sijoitus"]]

    end
  end
end

## Write district results to file

CSV.open( "partyresults.csv", 'w' ) do |writeline|

  writeline << ["Äänestysalue", "Puolue", "Paikkoja", "Prosenttiosuus paikoista"]

  resultData["seats"].each do |result|
    result[1].each do |partyInResult|

      percentageOfSeats = (100 * (partyInResult[1].to_f / result[1]["Totalseats"].to_f)).round(2)
      writeline << [result[0],partyInResult[0], partyInResult[1], percentageOfSeats]
    end
  end

end

## Write hometownresults to file

CSV.open( "hometownresults.csv", 'w' ) do |writeline|

  writeline << ["Äänestysalue", "Puolue", "Paikkoja", "Prosenttiosuus paikoista"]

  resultData["hometowns"].each do |district|
    district[1].each do |hometownInDistrict|

      percentageOfSeats = (100* (hometownInDistrict[1].to_f / district[1]["Totalseats"].to_f)).round(2)
      writeline << [district[0],hometownInDistrict[0], hometownInDistrict[1], percentageOfSeats]
    end
  end

end
