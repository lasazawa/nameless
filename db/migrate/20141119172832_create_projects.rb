class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.references :user

      t.timestamps
    end
  end
end
