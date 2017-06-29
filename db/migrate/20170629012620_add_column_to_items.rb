class AddColumnToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :ys_code, :string
    add_column :items, :ys_name, :string
    add_column :items, :ys_price, :integer
    add_column :items, :ys_url, :string
    add_column :items, :ys_image_url, :string
  end
end
