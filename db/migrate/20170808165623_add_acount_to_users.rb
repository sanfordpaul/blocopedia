class AddAcountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account, :integer
  end
end
