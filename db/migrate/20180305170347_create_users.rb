class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.datetime :last_login
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
