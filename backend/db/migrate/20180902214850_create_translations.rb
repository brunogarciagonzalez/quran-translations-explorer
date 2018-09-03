class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      t.string :author
      t.string :language
    end
  end
end
