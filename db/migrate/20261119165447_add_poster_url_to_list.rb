class AddPosterUrlToList < ActiveRecord::Migration[8.1]
  def change
    add_column :lists, :poster_url, :string
  end
end
