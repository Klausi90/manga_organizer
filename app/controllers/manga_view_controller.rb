class MangaViewController < ApplicationController
  def index
  end

  def delete
    Manga.find(params[:id]).destroy!
    redirect_to  action: :index
  end

  def show
  end

  def edit
  end

  def new
    Manga.create!(
      {
        name: params[:manga][:name],
        language: :en
      }
    )
    redirect_to  action: :index
  end

  def reset
    Manga.find(params[:id]).reset_all!
    redirect_to  action: :index
  end
end
