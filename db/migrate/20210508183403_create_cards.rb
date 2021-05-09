class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :original_text
      t.string :translated_text
      t.date :review_date
      t.string :picture
      t.belongs_to :user

      t.timestamps
    end
  end
end
