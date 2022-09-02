class AddDefaultValueToGroupColInChatroom < ActiveRecord::Migration[7.0]
  def change
    change_column_default :chatrooms, :group, false
  end
end
