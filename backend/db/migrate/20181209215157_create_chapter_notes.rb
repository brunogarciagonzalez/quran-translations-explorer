class CreateChapterNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :chapter_notes do |t|
      t.integer :study_space_id
      t.integer :chapter_id
      t.text :content
      t.timestamps
    end
  end
end
