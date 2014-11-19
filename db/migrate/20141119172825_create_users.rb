class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username
    	t.string :password
    	t.string :password_digest
    	# t.boolean :role, default: false
    	t.string :firstname
    	t.string :lastname
    	t.integer :age
    	t.string :city
    	t.string :picurl

      t.timestamps
    end
  end
end
