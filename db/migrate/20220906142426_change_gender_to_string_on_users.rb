class ChangeGenderToStringOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :gender, :string
  end
end
