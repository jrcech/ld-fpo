# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    sparql = SPARQL::Client.new('https://linked.opendata.cz/sparql')

    @subject = params[:id]

    @results = sparql.query("
      SELECT DISTINCT ?s ?name
      WHERE {
        ?s a gr:BusinessEntity .
        ?s adms:identifier [skos:notation '#{@subject}'] .
        ?s gr:legalName ?name .
      }
      LIMIT 100
    ")
  end
end
