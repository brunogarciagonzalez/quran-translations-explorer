class CreateStudySpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :study_spaces do |t|
      t.integer :user_id
      t.integer :study_space_id
      t.timestamps
    end
  end
end
