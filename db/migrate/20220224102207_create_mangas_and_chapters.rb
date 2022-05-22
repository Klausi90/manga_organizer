class CreateMangasAndChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :mangas do |t|
      t.bigint :current_chapter_id
      t.text :name
      t.integer :language
      t.timestamps
    end

    create_table :chapters do |t|
      t.string :name
      t.string :url
      t.integer :download_state
      t.timestamps
    end
  end
end
