class CreateVerseNoteHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :verse_note_histories do |t|
      t.integer :verse_note_id
      t.integer :user_id
      t.integer :revision_number
      t.text    :content
      t.timestamps
    end
  end
end
