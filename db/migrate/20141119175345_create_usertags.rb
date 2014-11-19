class CreateUsertags < ActiveRecord::Migration
  def change
    create_table :usertags do |t|
    	t.references :user
    	t.references :tag

      t.timestamps
    end
  end
end
