class CreateChapterScrapeSetting < ActiveRecord::Migration[6.0]
  def change
    create_table :chapter_scrape_settings do |t|
        t.bigint :manga_id
        t.string :origin_url
        t.string :image_list_css_string
    end
  end
end
