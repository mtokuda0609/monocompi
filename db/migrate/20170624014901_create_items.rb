class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.integer :benefit
      t.integer :stock
      t.string :rk_code
      t.string :rk_name
      t.integer :rk_price
      t.string :rk_url
      t.string :rk_image_url

      t.timestamps
      
      
    end
  end
end
