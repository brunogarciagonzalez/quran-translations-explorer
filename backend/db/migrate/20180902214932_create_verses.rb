class CreateVerses < ActiveRecord::Migration[5.2]
  def change
    create_table :verses do |t|
      t.integer :chapter_id
      t.integer :number
      t.text :content
    end
  end
end
