class CreateReport < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.references :medical_data, foreign_key: true
    end
  end
end
