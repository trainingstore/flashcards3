class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :original_text
      t.string :translated_text
      t.datetime :review_date
      t.string :picture
      t.integer :box, default: 0
      t.integer :wrong_guess, default: 0
      t.belongs_to :deck

      t.timestamps
    end
  end
end
