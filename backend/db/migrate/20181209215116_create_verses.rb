class CreateVerses < ActiveRecord::Migration[5.2]
  def change
    create_table :verses do |t|
      t.integer :chapter_id
      t.integer :number_in_chapter
      t.text :content
    end
  end
end
