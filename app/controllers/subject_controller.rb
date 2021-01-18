# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @item = OpenDataCz.find(@subject, params[:name]).first
    @address = OpenDataCz.address(@subject).first
    @zivnost = OpenDataCz.list_zivnost(@subject)
    @sanctions = OpenDataCz.coi_sanctions(@subject)
  end
end
