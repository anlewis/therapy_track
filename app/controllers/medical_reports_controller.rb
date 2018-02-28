class MedicalReportsController < ApplicationController
  def new
    @report = Report.find(params[:report_id])
    @medical_report = MedicalReport.new
  end

  def create
    report = Report.find(params[:report_id])
    @medical_report = report.create_medical_report(medical_report_params)
  end

  private
    def medical_report_params
      params.require(:medical_report).permit(:oxygen, :temperature, :systolic, :diastolic, :weight, :notes)
    end
end