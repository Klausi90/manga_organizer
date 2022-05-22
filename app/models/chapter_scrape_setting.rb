# == Schema Information
#
# Table name: manga_scrape_settings
#
#  id                      :bigint           not null, primary key
#  image_list_css_string   :string
#  origin_url              :string
#  manga_id                :bigint
#
class ChapterScrapeSetting < ApplicationRecord

  belongs_to :manga
end
