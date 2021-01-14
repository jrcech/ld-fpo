# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    sparql = SPARQL::Client.new('https://linked.opendata.cz/sparql')

    @subject = params[:id]

    @results = sparql.query("
      SELECT DISTINCT ?s ?name ?id
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{@subject}'] .
        ?s gr:legalName ?name .
        ?s adms:identifier [skos:notation ?id] .
        FILTER regex(?s, 'business-entity', 'i')
      }
      LIMIT 100
    ")

    @zivnost = sparql.query("
      PREFIX dc:<http://purl.org/dc/terms/>
      SELECT DISTINCT ?zivnost
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{@subject}'] .
        ?s ares:zivnost [dc:title ?zivnost] .
        FILTER regex(?s, 'business-entity', 'i')
      }
      LIMIT 100
    ")
  end
end
