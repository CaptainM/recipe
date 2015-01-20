class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username
    	t.string :password_digest
    	t.string :first_name

    	t.timestamps
    end
  end
end
