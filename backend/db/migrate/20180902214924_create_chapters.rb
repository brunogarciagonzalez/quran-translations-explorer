class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.integer :translation_id
      t.integer :number
      t.string :title
    end
  end
end
