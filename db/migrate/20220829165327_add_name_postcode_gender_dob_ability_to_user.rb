class AddNamePostcodeGenderDobAbilityToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :postcode, :string
    add_column :users, :gender, :integer
    add_column :users, :dob, :date
    add_column :users, :ability, :integer
  end
end
