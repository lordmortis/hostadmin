class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.uuid :id, primary_key: true, null: false
      t.string :email,              null: false, default: ""
      t.string :username
      t.string :password_digest,    null: false
      t.column :status, :integer,   default: 0

      t.timestamps
    end
  end
end
