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

## Linsenssi: MIT License

MIT License

Copyright (c) 2017 Helsingin Sanomat

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.