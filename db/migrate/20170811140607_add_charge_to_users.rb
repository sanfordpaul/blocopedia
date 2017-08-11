class AddChargeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :charge, :string
  end
end
