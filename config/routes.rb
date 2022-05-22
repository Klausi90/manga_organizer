Rails.application.routes.draw do
  get 'manga_view/index'
  get 'manga_view/show'
  get 'manga_view/edit'
  post 'manga_view/new'
  delete 'manga_view/delete'
  get 'manga_view/reset'
  get 'scrape/scrape_chapter_list'
  get 'scrape/scrape_chapter'
  get 'scrape/bulk_scrape_chapter'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
