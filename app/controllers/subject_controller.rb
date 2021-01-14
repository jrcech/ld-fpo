# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @results = OpenDataCz.find(@subject)
    @zivnost = OpenDataCz.list_zivnost(@subject)
    @coi = OpenDataCz.coi(@subject)
  end
end
