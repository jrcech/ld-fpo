# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @results = OpenDataCz.find(@subject, params[:name])
    @zivnost = OpenDataCz.list_zivnost(@subject)
    @address = OpenDataCz.address(@subject)
    @sanctions = OpenDataCz.coi_sanctions(@subject)
  end
end
