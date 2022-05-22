# == Schema Information
#
# Table name: manga_scrape_settings
#
#  id                      :bigint           not null, primary key
#  chapter_list_css_string :string
#  origin_url              :string
#  manga_id                :bigint
#
class MangaScrapeSetting < ApplicationRecord

  belongs_to :manga
end
