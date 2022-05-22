# == Schema Information
#
# Table name: mangas
#
#  id                 :bigint           not null, primary key
#  language           :integer          default("de")
#  name               :text
#  process            :integer          default("initialized")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  current_chapter_id :bigint
#
# Indexes
#
#  mangas_current_chapter_id_uindex  (current_chapter_id) UNIQUE
#
class Manga < ApplicationRecord
  require 'fileutils'

  enum language: {
    de: 1,
    en: 2,
    jp: 3
  }

  enum process: {
    initialized: 0,
    pending_for_new_chapter: 1,
    load_new_chapter_list: 2,
    failed_loading_new_chapter: 3,
    manga_completed: 4
  }

  belongs_to :current_chapter, class_name: "Chapter", optional: true
  has_many :chapters
  has_one :manga_scrape_setting
  has_one :chapter_scrape_setting

  validates :language, presence: true
  validates :name, presence: true

  after_create do
    if self.manga_scrape_setting.blank?
      MangaScrapeSetting.new({manga_id: self.id}).save
      ChapterScrapeSetting.new({manga_id: self.id}).save
    end
  end

  def reset_all!
    FileUtils.rm_rf("./#{name}_#{language.titleize}") if self.chapters.any?
    chapters.destroy_all
  end
end
