# frozen_string_literal: true

class HomepageController < ApplicationController
  def index; end

  def search
    @query = params[:query]

    if @query.to_i != 0 && @query.to_i.digits.size == 8
      @results = OpenDataCz.search_by_id(@query.to_i)
    elsif @query.size < 4
      flash[:error] = 'Zadejte alespoň 4 znaky'
    else
      @results = OpenDataCz.search(@query)
    end

    render :index
  end
end
