class RenameInstrumentsTypeToName < ActiveRecord::Migration[7.0]
  def change
    rename_column :instruments, :type, :name
  end
end
