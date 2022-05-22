class AddProcessStateToManga < ActiveRecord::Migration[6.0]
  def change
    add_column(:mangas, :process, :integer, default: 0)
  end
end
