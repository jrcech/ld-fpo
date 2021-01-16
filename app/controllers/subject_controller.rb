# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @results = OpenDataCz.find(@subject)
    ap @results
    ap @results.size

    @zivnost = OpenDataCz.list_zivnost(@subject)
    ap @zivnost

    @address = OpenDataCz.address(@subject)
    ap @address

    @sanctions = OpenDataCz.coi_sanctions(@subject)

    # ap OpenDataCz.coi_check_dates(@subject).size
    # ap OpenDataCz.coi_check_instruments(@subject).map { |check| check.instrument.to_s }.group_by(&:itself).map { |key, value| [key, value.size]  }
    # ap OpenDataCz.coi_sanctions(@subject).map { |solution| solution.sanction.to_i }.sum
    # ap OpenDataCz.coi_sanctions(@subject).map(&:sanction)
    # ap OpenDataCz.coi_check_types(@subject).size
    # ap OpenDataCz.coi_check_types(@subject).map { |solution| solution.type.to_s.split('/').last }.group_by(&:itself).map { |key, value| [key, value.size]  }
  end
end
