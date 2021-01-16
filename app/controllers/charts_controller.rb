class ChartsController < ApplicationController
  def coi
    dates = []

    OpenDataCz.coi(params[:id]).each_solution do |solution|
      dates << solution.date.to_s.to_date
    end

    render json: dates.group_by_month { |u| u }.map { |k, v| [k, v.count] }
  end
end