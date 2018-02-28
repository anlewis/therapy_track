class CreateMedicalData < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_data do |t|
      t.integer :oxygen_saturation
      t.integer :temperature
      t.integer :weight
      t.integer :systolic
      t.integer :diastolic
      t.text    :notes
    end
  end
end
