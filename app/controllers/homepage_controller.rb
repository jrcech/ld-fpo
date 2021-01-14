# frozen_string_literal: true

class HomepageController < ApplicationController
  def index; end

  def search
    @query = params[:query]

    @results = OpenDataCz.search(@query)

    render :index
  end
end
