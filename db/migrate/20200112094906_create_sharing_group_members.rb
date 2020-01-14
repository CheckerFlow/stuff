class CreateSharingGroupMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :sharing_group_members do |t|
      t.integer :user_id
      t.string :email
      t.bigint :shareable_id
      t.string :shareable_type
      t.timestamps
    end

    add_index :sharing_group_members, [:shareable_type, :shareable_id]
  end
end
