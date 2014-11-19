class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.references :user
    	t.references :name

      t.timestamps
    end
  end
end
