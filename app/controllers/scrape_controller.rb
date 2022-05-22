class ScrapeController < ApplicationController

  def bulk_scrape_chapter
    manga = Manga.find(params[:id])

    chapter_count = 0
    manga.chapters.pending.limit(50).each do |chapter|
      ChapterScraper.scrape_all_images(chapter)
      chapter_count += 1
    end

    flash[:info] = "Successfully scraped #{chapter_count}"

    redirect_back fallback_location: manga_view_index_path

  end

  def scrape_chapter
    manga = Manga.find(params[:id])

    chapter = manga.current_chapter
    ChapterScraper.scrape_all_images(chapter)

    if chapter.error?
      flash[:error] = "Failed scraped #{chapter.number}"
      redirect_back fallback_location: manga_view_index_path
    end
    flash[:info] = "Successfully scraped #{chapter.number}"

    redirect_back fallback_location: manga_view_index_path
  rescue StandardError => e
    return redirect_back fallback_location: manga_view_index_path, danger: e.message, info: e.backtrace[0..5].join(' ')
  end

  def scrape_chapter_list
    #'http://onepiece-tube.com/kapitel-mangaliste'
    manga = Manga.find(params[:id])
    settings = manga.manga_scrape_setting
    url = settings.origin_url
    response = ChapterListScraper.process(url, settings)
    if response[:status] == :completed && response[:error].nil?
      flash[:info] = "Chapterlist aktualisiert"
      manga.save
    else
      flash[:danger] = response[:error]
    end
    return redirect_back fallback_location: manga_view_index_path
  rescue StandardError => e
    flash[:danger] = "Error: #{e}"
    return redirect_back fallback_location: manga_view_index_path
  end

end
