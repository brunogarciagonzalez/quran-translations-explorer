class CreateChapterNoteHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :chapter_note_histories do |t|
      t.integer :chapter_note_id
      t.integer :user_id
      t.integer :revision_number
      t.text    :content
      t.timestamps
    end
  end
end
