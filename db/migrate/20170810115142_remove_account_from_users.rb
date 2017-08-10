class RemoveAccountFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :account, :integer
  end
end
