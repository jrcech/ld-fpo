# frozen_string_literal: true

module OpenDataCz
  @sparql = SPARQL::Client.new('https://linked.opendata.cz/sparql')

  def self.search(query)
    @sparql.query("
      SELECT DISTINCT ?id ?name
      WHERE {
        ?s gr:legalName ?name ;
          adms:identifier [skos:notation ?id] .

        ?name bif:contains \"'#{query}*'\" .

        FILTER regex(?s, 'business-entity', 'i')
      }
      LIMIT 100
    ")
  end

  def self.search_by_id(query)
    @sparql.query("
      SELECT DISTINCT ?id ?name
      WHERE {
        ?s adms:identifier [skos:notation '#{query}'] ;
          gr:legalName ?name ;
          adms:identifier [skos:notation ?id] .

        FILTER regex(?s, 'business-entity', 'i')
      }
      LIMIT 100
    ")
  end

  def self.find(id)
    @sparql.query("
      PREFIX dct:<http://purl.org/dc/terms/>
      PREFIX schema:<http://schema.org/>

      SELECT DISTINCT ?name ?date_issued ?zakladni_kapital
      WHERE {
        ?s adms:identifier [skos:notation '#{id}'] ;
          gr:legalName ?name .

        OPTIONAL {
          ?s dct:issued ?date_issued ;
          ares:zakladni-kapital [gr:hasCurrencyValue ?zakladni_kapital] .
        }

        FILTER regex(?s, 'business-entity', 'i')
      }
    ")
  end

  def self.address(id)
    @sparql.query("
      PREFIX dct:<http://purl.org/dc/terms/>
      PREFIX schema:<http://schema.org/>

      SELECT DISTINCT ?country ?locality ?postal_code ?street
      WHERE {
        ?s adms:identifier [skos:notation '#{id}'] .
        ?s schema:address ?address .

        ?address schema:addressCountry ?country ;
          schema:addressLocality ?locality ;
          schema:postalCode ?postal_code ;
          schema:streetAddress ?street .

        FILTER regex(?address, 'ares', 'i')
      }
    ")
  end

  def self.list_zivnost(id)
    @sparql.query("
      PREFIX dct:<http://purl.org/dc/terms/>

      SELECT DISTINCT ?zivnost
      WHERE {
        ?s adms:identifier [skos:notation '#{id}'] ;
          ares:zivnost [dct:title ?zivnost] .

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
        ?s a [rdfs:label 'Check action'] ;
          schema:object [adms:identifier [skos:notation '#{id}']] ;
          dct:date ?date .
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
        ?s a [rdfs:label 'Check action'] ;
          schema:object [adms:identifier [skos:notation '#{id}']] ;
          dct:date ?date ;
          schema:result [a coi:Sanction] ,
            [schema:result [gr:hasCurrencyValue ?sanction]] .
      }
    ")
  end

  def self.coi_check_instruments(id)
    @sparql.query("
      PREFIX schema:<http://schema.org/>

      SELECT DISTINCT ?s ?instrument
      WHERE {
        ?s a [rdfs:label 'Check action'] ;
          schema:object [adms:identifier [skos:notation '#{id}']] ;
          schema:instrument ?instrument .
      }
    ")
  end

  def self.coi_check_types(id)
    @sparql.query("
      PREFIX schema:<http://schema.org/>

      SELECT DISTINCT ?s ?type
      WHERE {
        ?s a [rdfs:label 'Check action'] ;
          schema:object [adms:identifier [skos:notation '#{id}']] ;
          schema:result [a ?type] .
      }
    ")
  end
end
