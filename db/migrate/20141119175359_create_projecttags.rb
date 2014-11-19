class CreateProjecttags < ActiveRecord::Migration
  def change
    create_table :projecttags do |t|
    	t.references :project
    	t.references :tag

      t.timestamps
    end
  end
end
