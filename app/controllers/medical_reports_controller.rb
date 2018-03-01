class MedicalReportsController < ApplicationController
  def new
    @report = Report.find(params[:report_id])
    @medical_report = MedicalReport.new
  end

  def create
    report = Report.find(params[:report_id])
    @medical_report = report.create_medical_report(medical_report_params)
    redirect_to report_submit_path(report.id)
  end

  private

  def medical_report_params
    params.require(:medical_report).permit(:oxygen, :temperature, :systolic, :diastolic, :weight, :notes)
  end
end
