class AddBannerImgColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :banner_img_url, :string
  end
end
