class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains, id: false do |t|
      t.uuid :id, primary_key: true, null: false
      t.string :name, null: false
      t.integer :features_store, array: true
      t.timestamps null: false

      t.timestamps
    end
  end
end
