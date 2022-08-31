class AddListableToInstruments < ActiveRecord::Migration[7.0]
  def change
    add_column :instruments, :listable, :boolean
  end
end
