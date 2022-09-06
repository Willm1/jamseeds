class ChangeImageUrlColumnNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :image_url, :profile_img_url
  end
end
