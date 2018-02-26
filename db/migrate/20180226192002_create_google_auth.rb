class CreateGoogleAuth < ActiveRecord::Migration[5.1]
  def change
    create_table :google_auths do |t|
      t.references :user, foreign_key: true
      t.string :access_token
      t.string :token_type
      t.integer :expires_in
      t.string :refresh_token
    end
  end
end
