class AddFamNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fam_name, :string
    add_column :users, :giv_name, :string
    add_column :users, :fam_name_kana, :string
    add_column :users, :giv_name_kana, :string
  end
end
