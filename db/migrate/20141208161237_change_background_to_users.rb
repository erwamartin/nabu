class ChangeBackgroundToUsers < ActiveRecord::Migration
   def self.up
    change_table :users do |t|
      t.attachment :background
    end
  end

  def self.down
    drop_attached_file :users, :background
  end
end
