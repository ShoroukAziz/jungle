class AddIndexInUsersOnName < ActiveRecord::Migration[6.1]
  def change
    add_index :users, "lower(email)", name: "index_users_on_lower_name", unique: true
  end
end
