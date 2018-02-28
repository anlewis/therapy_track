class CreateMedicalReport < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_reports do |t|
      t.references :report, foreign_key: true
      t.integer :oxygen
      t.integer :temperature
      t.integer :weight
      t.integer :systolic
      t.integer :diastolic
      t.text :notes

      t.timestamps
    end
  end
end
