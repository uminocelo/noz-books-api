class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.date :publication_date
      t.string :publisher
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
