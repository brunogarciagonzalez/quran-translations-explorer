class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.integer :study_space_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
  end
end
