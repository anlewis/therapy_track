class AddCalendarToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :calendar, :string
  end
end
