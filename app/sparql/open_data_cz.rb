# frozen_string_literal: true

module OpenDataCz
  @sparql = SPARQL::Client.new('https://linked.opendata.cz/sparql')

  def self.search(query)
    @sparql.query("
      SELECT DISTINCT ?name ?s ?id
      WHERE {
        ?s a gr:BusinessEntity .
        ?s gr:legalName ?name .
        ?name bif:contains \"'#{query}*'\" .
        ?s adms:identifier [skos:notation ?id] .
        FILTER regex(?s, 'business-entity', 'i')
      }
    ")
  end

  def self.find(id)
    @sparql.query("
      SELECT DISTINCT ?s ?name ?id
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{id}'] .
        ?s gr:legalName ?name .
        ?s adms:identifier [skos:notation ?id] .
        FILTER regex(?s, 'business-entity', 'i')
      }
    ")
  end

  def self.list_zivnost(id)
    @sparql.query("
      PREFIX dc:<http://purl.org/dc/terms/>
      SELECT DISTINCT ?zivnost
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{id}'] .
        ?s ares:zivnost [dc:title ?zivnost] .
        FILTER regex(?s, 'business-entity', 'i')
      }
    ")
  end

  def self.coi(id)
    @sparql.query("
      PREFIX sch:<http://schema.org/>
      PREFIX dc:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?notation ?date ?instrument
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s sch:object [adms:identifier [skos:notation '#{id}']] .
        ?s sch:instrument ?instrument .
        ?s skos:notation ?notation .
        ?s dc:date ?date .
      }
    ")
  end
end
