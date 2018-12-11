class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      t.integer :verse_id
      t.string :author
      t.text :language
      t.text :content
    end
  end
end
