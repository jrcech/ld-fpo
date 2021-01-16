# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @results = OpenDataCz.find(@subject)
    @zivnost = OpenDataCz.list_zivnost(@subject)

    @sanctions = OpenDataCz.coi_sanctions(@subject)

    # ap OpenDataCz.coi_sanctions(@subject).size
    # ap OpenDataCz.coi_sanctions(@subject).map { |solution| solution.sanction.to_i }.sum
    # ap OpenDataCz.coi_sanctions(@subject).map(&:sanction)
  end
end
