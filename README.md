# README

Aplikace je dostupná veřejně na adrese: https://ld-fpo.jiricech.com

Případně: https://ld-fpo.herokuapp.com

Kód je rovněž dostupny ná GitHubu: https://github.com/jrcech/ld-fpo

SPARQL dotazy se ncházejí ve složce `app/sparql`.

Zajímavé výsledky:
- Ahold
- Lidl
- Penny Market
- Obecně velké společnosti s bohatou historií

Nezajímavé výsledky:
- Obecně fyzické osoby, protože nemají příliš dat. Pouze u některých lze získat adresu, datovou schránku, atd...

## Návod na spuštění lokální verze
Pro vytvoření a spuštění lokální verze aplikace je nutné mít nainstalovaný Docker.

V adresáři s aplikací `ld-fpo` je pak třeba spustit příkazy:
1. `docker build -t ld-fpo .`
2. `docker run -p 3000:3000 ld-fpo`

Aplikace bude následně dostupná na stránce: http://localhost:3000

## Užitečné odkazy k práci
https://linked.opendata.cz/fct/facet.vsp

https://linked.opendata.cz/sparql
