class ChapterListScraper < Kimurai::Base
  @name = 'spider'
  @engine = :mechanize

  def self.process(url, settings)
    settings.manga.load_new_chapter_list!
    @start_urls = [url]
    self.crawl!
    # current_setting&.chapter_list_css_string
  end

  def parse(response, url:, data: {})
    manga = Manga.load_new_chapter_list.first!
    response.xpath(manga.manga_scrape_setting.chapter_list_css_string).css('tr').each do |chapter|
      item = {}

      number = chapter.css('td').first&.text&.squish.to_i
      next if number.blank? || number == 0

      item[:name]      = chapter.css('td')[1]&.content&.squish
      item[:number]    = number
      item[:manga_id]    = manga.id


      # "Tip('<img src=\\'/kapitel/1043/01.png\\' width=\\'300\\' height=\\'480\\' >')"
      # /(\/kapitel)\/(\d)+\//
      # ->"/kapitel/1043/"
      chapter_url = chapter.css('td')[1].attributes['onmouseover'].value
      # 'http://' + 'onepiece-tube.com' + "/kapitel/1043/" + "1"
      # -> http://onepiece-tube.com/kapitel/1043/1
      chapter_url = 'http://' + URI.parse(url).host  + chapter_url.match(/(\/kapitel)\/(\d)+\//).to_s + "1"
      item[:url]    = chapter_url

      Chapter.where(item).first_or_create!
    end
    # set all new Chapter to pending
    Chapter.where(download_state: nil).update_all(download_state: :pending)
    manga.current_chapter = manga.chapters.order(number: :desc).first
    manga.save
  end

end