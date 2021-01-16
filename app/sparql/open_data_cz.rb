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

  def self.coi_check_dates(id)
    @sparql.query("
      PREFIX sch:<http://schema.org/>
      PREFIX dc:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?date
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s sch:object [adms:identifier [skos:notation '#{id}']] .
        ?s dc:date ?date .
      }
    ")
  end

  def self.coi_check_instruments(id)
    @sparql.query("
      PREFIX sch:<http://schema.org/>
      PREFIX dc:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?instrument
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s sch:object [adms:identifier [skos:notation '#{id}']] .
        ?s sch:instrument ?instrument .
      }
    ")
  end

  def self.coi_check_types(id)
    @sparql.query("
      PREFIX sch:<http://schema.org/>
      PREFIX dc:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?type
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s sch:object [adms:identifier [skos:notation '#{id}']] .
        ?s sch:result [a ?type] .
      }
    ")
  end

  def self.coi_sanctions(id)
    @sparql.query("
      PREFIX sch:<http://schema.org/>
      PREFIX dc:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?date ?sanction
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s sch:object [adms:identifier [skos:notation '#{id}']] .
        ?s dc:date ?date .
        ?s sch:result [sch:result [gr:hasCurrencyValue ?sanction]] .
        ?s sch:result [a <http://data.coi.cz/ontology/Sanction>] .
      }
    ")
  end

  def self.template(id)
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
