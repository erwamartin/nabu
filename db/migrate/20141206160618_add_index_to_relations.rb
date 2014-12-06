class AddIndexToRelations < ActiveRecord::Migration
  def change
  	add_index :relations, [:follower_id, :following_id], :unique=> true
  end
end
