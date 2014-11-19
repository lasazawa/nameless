class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.string :name
    	t.text :description
    	t.integer :created_by

      t.timestamps
    end
  end
end
