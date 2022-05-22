class AddChaoptersNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :number, :integer, not_null: false
  end
end
