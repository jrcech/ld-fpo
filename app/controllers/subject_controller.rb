# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @results = OpenDataCz.find(@subject)
    @zivnost = OpenDataCz.list_zivnost(@subject)

    @sanctions = OpenDataCz.coi_check_sanctions_sum(@subject)
  end
end
