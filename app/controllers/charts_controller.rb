# frozen_string_literal: true

class ChartsController < ApplicationController
  def coi
    dates = []

    OpenDataCz.coi(params[:id]).each_solution do |solution|
      dates << solution.date.to_s.to_date
    end

    render json: dates.group_by_month { |date| date }.map { |key, value| [key, value.count] }
  end
end
