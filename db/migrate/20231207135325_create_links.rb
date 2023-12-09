class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :slug, null: false
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.string :password_digest
      t.date :expiration_date
      t.timestamps
    end

    add_index :links, :slug, unique: true
    add_index :links, :url

  end
end
