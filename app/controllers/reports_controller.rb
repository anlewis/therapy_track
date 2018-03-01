class ReportsController < ApplicationController
  def index
  end

  def show
    @report = Report.find(params[:id])
  end

  def create
    report = Report.create
    current_user.reports << report
    redirect_to new_report_medical_report_path(report)
  end
end