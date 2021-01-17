# README

Aplikace je dostupná veřejně na adrese: http://ld-fpo.jiricech.com, případně: https://floating-island-85089.herokuapp.com/

SPARQL dotazy se ncházejí ve složce `app/sparql`.

Zajímavé výsledky:
- Ahold
- Lidl
- Penny Market

## Návod na spuštění lokální verze
Pro vytvoření a spuštění lokální verze aplikace je nutné mít nainstalovaný Docker.

V adresáři s aplikací `ld-fpo` je pak třeba spustit příkazy:
1. `docker build -t ld-fpo .`
2. `docker run -p 3000:3000 ld-fpo`

Aplikace bude následně dostupná na stránce: http://localhost:3000

## Užitečné odkazy k práci
https://linked.opendata.cz/fct/facet.vsp

https://linked.opendata.cz/sparql
