# frozen_string_literal: true

class SubjectController < ApplicationController
  def index; end

  def show
    @subject = params[:id]

    @results = OpenDataCz.find(params[:id])
    @zivnost = OpenDataCz.list_zivnost(params[:id])
    @coi = OpenDataCz.coi(params[:id])
  end
end
