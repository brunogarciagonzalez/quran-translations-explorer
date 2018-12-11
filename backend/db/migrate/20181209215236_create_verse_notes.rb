class CreateVerseNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :verse_notes do |t|
      t.integer :study_space_id
      t.integer :verse_id
      t.text :content
      t.timestamps
    end
  end
end
