class CreateDomainUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_users, id: false do |t|
      t.uuid :domain_id, null: false
      t.uuid :user_id, null: false
      t.integer :permissions_store, array: true

      t.timestamps null: false
    end

    add_foreign_key :domain_users, :domains
    add_foreign_key :domain_users, :users
  end
end
