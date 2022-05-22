class ImageSaver
  require "down"
  require "fileutils"

  def initialize(chapter)
    @chapter = chapter
    @manga = chapter.manga
    @url = nil
  end

  def save_image(url)
    @url = url
    unless directory_exists?(dir_path)
      FileUtils.mkdir_p dir_path
    end

    # "https://manga-lesen.com/kapitel/1017/01.png?v3" -> "https://manga-lesen.com/kapitel/1017/01.png"
    @url = @url.split('?').first
    tempfile = Down.download(@url)
    unless File.exist?("#{dir_path}/#{tempfile.original_filename}")
      FileUtils.mv(tempfile.path, "#{dir_path}/#{tempfile.original_filename}")
    end
  end

  def dir_path(abs = true)
    unless abs
      return "./#{@manga.name}_#{@manga.language.titleize}".join("#{@chapter.number}_#{@chapter.name}")
    end

    Rails.root.join("#{@manga.name}_#{@manga.language.titleize}").join("#{@chapter.number}_#{@chapter.name}")
  end

  private

  def directory_exists?(directory)
    return false if Dir[directory].blank?
    true
  end
end
