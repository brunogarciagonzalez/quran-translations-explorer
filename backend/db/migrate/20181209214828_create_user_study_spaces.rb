class CreateUserStudySpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :user_study_spaces do |t|
      t.string :space_name
      t.timestamps
    end
  end
end
