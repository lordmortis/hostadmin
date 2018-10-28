class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions, id: false do |t|
      t.uuid :id, primary_key: true, null: false
      t.integer :authable_id
      t.string :authable_type
      t.string :device_name
      t.boolean :http_only, null: false
      t.binary :secret, null: false
      t.datetime :expires_at, null: false
      t.timestamps null: false
    end
    add_index :sessions, [:authable_type, :authable_id]
  end
end
