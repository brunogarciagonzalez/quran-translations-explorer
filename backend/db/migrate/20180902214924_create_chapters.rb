class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.integer :translation_id
      t.integer :number
      t.string :title
      t.boolean :requires_addition_of_bismillah
    end
  end
end
