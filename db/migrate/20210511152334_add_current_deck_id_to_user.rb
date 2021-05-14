class AddCurrentDeckIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_deck_id, :integer
  end
end
