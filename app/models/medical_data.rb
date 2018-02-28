class MedicalData < ApplicationRecord
  belongs_to :report
  belongs_to :user, through: :report
end