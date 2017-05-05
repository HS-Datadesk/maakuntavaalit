# Eduskunta- ja maakuntavaalien simulaatio kuntavaalidatan pohjalta

Tämä ohjelma simuloi eduskunta- ja maakuntavaalit kuntavaalituloksen pohjalta.

## Maakuntavaltuustojen koot

Tiedostossa mappings.rb määritellään, mikä kunta kuuluu mihinkin maakuntaan ja mitkä ovat maakuntavaltuustojen koot. Samassa tiedostossa on myös vastaavat tiedot eduskuntavaaleista käyttäen 2015 vaalidataa.

Maakuntavaltuustojen koot: http://www.hs.fi/kotimaa/art-2000002893580.html
Maakuntien väkiluvut: http://pxnet2.stat.fi/PXWeb/pxweb/fi/StatFin/StatFin__vrm__vamuu/001_vamuu_tau_107.px/table/tableViewLayout1/?rxid=2967e8e8-6bc4-4d37-baf5-76480444fa8a


## Candidates.csv:n kentät

Candidates.csv on peräisin HS:n tulospalvelusta ja oikeusministeriöstä. Se sisältää seuraavat kentät

Etunimi	0
Numero	1
Sukunimi	2
Puolue	3
Vaalipiiri	4
Ikä	5
Sukupuoli	6
Kotinkunta	7
Menikö läpi?	8
Ennakkoäänet	9
Äänet vaalipäivänä	10
Äänet yhteensä	11
Äänet viime vaaleissa	12
Äänimäärän muutos	13
Osuus vaalipiirin äänistä	14
Osuus vaalipiirin äänistä ennakkoon	15
Osuus vaalipiirin äänistä vaalipäivänä	16
Vertailuluku	17
