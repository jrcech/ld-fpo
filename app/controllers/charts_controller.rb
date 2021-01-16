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

    render json: dates.group_by_month { |date| date[0] }.map { |key, value| [key, value.map { |sanction| sanction[1] }.sum ] }
  end

  def coi_instruments
    render json: OpenDataCz.coi_check_instruments(params[:id]).map { |check| check.instrument.to_s }.group_by(&:itself).map { |key, value| [key, value.size]  }
  end

  def coi_check_types
    render json: OpenDataCz.coi_check_types(params[:id]).map { |solution| solution.type.to_s.split('/').last }.group_by(&:itself).map { |key, value| [key, value.size]  }
  end
end
