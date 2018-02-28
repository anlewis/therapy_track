class Report < ApplicationRecord
  belongs_to :user
  has_one :medical_report
end
