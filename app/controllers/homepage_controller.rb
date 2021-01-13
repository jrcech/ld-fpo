# frozen_string_literal: true

class HomepageController < ApplicationController
  def index; end

  def search
    sparql = SPARQL::Client.new('https://linked.opendata.cz/sparql')

    @query = params[:query]

    @results = sparql.query("
      SELECT DISTINCT ?name ?s
      WHERE {
        ?s a gr:BusinessEntity .
        ?s gr:legalName ?name .
        ?name bif:contains \"'#{@query}*'\" .
      }
      LIMIT 100
    ")

    render :index
  end
end
