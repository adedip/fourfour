class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.text :squares
      t.integer :user_one
      t.integer :user_two

      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
