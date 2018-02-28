class SubmissionController < ApplicationController
  def show
    @report = Report.find(params[:report_id])
  end

  def update
    report = Report.find(params[:report_id])
    report.update(status: 1)
    redirect_to report_path(report)
  end
end