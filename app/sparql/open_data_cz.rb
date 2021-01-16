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
      LIMIT 100
    ")
  end

  def self.search_by_id(query)
    @sparql.query("
      SELECT DISTINCT ?s ?name ?id
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{query}'] .
        ?s adms:identifier [skos:notation ?id] .
        ?s gr:legalName ?name .
        FILTER regex(?s, 'business-entity', 'i')
      }
      LIMIT 100
    ")
  end

  def self.find(id)
    @sparql.query("
      PREFIX dct:<http://purl.org/dc/terms/>
      PREFIX schema:<http://schema.org/>

      SELECT DISTINCT ?s ?name ?id ?date_issued ?address
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{id}'] .
        ?s gr:legalName ?name .
        ?s adms:identifier [skos:notation ?id] .
        ?s dct:issued ?date_issued .
        ?s schema:address ?address .
        FILTER (regex(?s, 'business-entity', 'i') && regex(?address, 'ares', 'i'))
      }
    ")
  end

  def self.list_zivnost(id)
    @sparql.query("
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
      PREFIX schema:<http://schema.org/>
      PREFIX dct:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?date
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s schema:object [adms:identifier [skos:notation '#{id}']] .
        ?s dct:date ?date .
      }
    ")
  end

  def self.coi_check_instruments(id)
    @sparql.query("
      PREFIX schema:<http://schema.org/>

      SELECT DISTINCT ?s ?instrument
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s schema:object [adms:identifier [skos:notation '#{id}']] .
        ?s schema:instrument ?instrument .
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
      PREFIX schema:<http://schema.org/>
      PREFIX dct:<http://purl.org/dc/terms/>
      PREFIX coi:<http://data.coi.cz/ontology/>

      SELECT DISTINCT ?s ?date ?sanction
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s schema:object [adms:identifier [skos:notation '#{id}']] .
        ?s dct:date ?date .
        ?s schema:result [schema:result [gr:hasCurrencyValue ?sanction]] .
        ?s schema:result [a coi:Sanction] .
      }
    ")
  end

  def self.template(id)
    @sparql.query("
      PREFIX schema:<http://schema.org/>
      PREFIX dct:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?s ?notation ?date ?instrument
      WHERE {
        ?s a [rdfs:label 'Check action'] .
        ?s schema:object [adms:identifier [skos:notation '#{id}']] .
        ?s schema:instrument ?instrument .
        ?s skos:notation ?notation .
        ?s dct:date ?date .
      }
    ")
  end
end
