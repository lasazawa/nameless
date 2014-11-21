class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.references :user
      t.string :name
      t.text :description
      t.string :photo_url
      t.string :emails
      t.string :nonce
      t.string :ptoken
      t.timestamps
    end
  end
end
