class AddWikiToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :wiki, foreign_key: true
  end
end
