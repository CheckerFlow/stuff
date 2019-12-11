class CreateEarlyAccessRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :early_access_requests do |t|
      t.string :email

      t.timestamps
    end
  end
end
