class ChapterScraper < Kimurai::Base
  @name = 'spider'
  @engine = :mechanize

  def self.scrape_all_images(chapter)
      chapter_image_count = 1
      chapter.in_progress!
    begin
      while chapter_image_count < 30 do
        url = chapter.url
        url = url[0..-2] + chapter_image_count.to_s
        response = ChapterScraper.process(url, chapter.manga.manga_scrape_setting)
        chapter_image_count += 1
      end
    rescue RuntimeError => e
      # get an 404 because end of range from chapter_image_count
      if response[:error].blank? && response[:status] == :completed

        Rails.logger.info "--------------------> Chapter Successfully scrapped #{chapter_image_count - 1} Images"
        Rails.logger.info e.message
        chapter.success!
      else
        chapter.error!
      end
    rescue Exception => e
      # generally a fails while scraping
      # set to pending if fails
      chapter.error!
      raise e
    end
  end

  def self.process(url, settings)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    chapter = Chapter.in_progress.first!
    service = ::ImageSaver.new(chapter)
    response.xpath("//img[@id='p']").each do |image|
      service.save_image( image.attributes['src'].value)
    end
  end

end