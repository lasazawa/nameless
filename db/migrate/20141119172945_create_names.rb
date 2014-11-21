class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
    	t.references :project
      t.string :name
      t.string :created_by 
      t.timestamps
    end
  end
end
