class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
    	t.references :project

      t.timestamps
    end
  end
end
