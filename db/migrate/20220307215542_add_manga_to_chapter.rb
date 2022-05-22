class AddMangaToChapter < ActiveRecord::Migration[6.0]
  def change
    add_column(:chapters, :manga_id, :bigint)
    change_column(:chapters, :url, :string )
  end
end
