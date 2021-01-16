# frozen_string_literal: true

class ChartsController < ApplicationController
  def coi
    dates = []

    OpenDataCz.coi_check_dates(params[:id]).each_solution do |solution|
      dates << solution.date.to_s.to_date
    end

    render json: dates.group_by_month { |date| date }.map { |key, value| [key, value.size] }
  end

  def coi_sanctions
    dates = []

    OpenDataCz.coi_sanctions(params[:id]).each_solution do |solution|
      dates << [solution.date.to_s.to_date, solution.sanction.to_i]
    end

    render json: dates.group_by_month { |date| date[0] }.map { |key, value|
                   [key, value.map do |sanction|
                           sanction[1]
                         end.sum]
                 }
  end

  def coi_instruments
    render json: OpenDataCz.coi_check_instruments(params[:id]).map do |check|
      check.instrument.to_s
    end.group_by(&:itself).map { |key, value| [key, value.size] }
  end
end
