class AddUserIdToStorage < ActiveRecord::Migration[6.0]
  def change
    add_column :storages, :user_id, :integer
  end
end
