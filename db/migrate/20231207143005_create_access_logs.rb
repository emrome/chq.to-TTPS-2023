class CreateAccessLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :access_logs do |t|
      t.string :ip_address, null: false
      t.datetime :access_date, null: false
      t.references :link, null: false, foreign_key: true
    end

    add_index :access_logs, [:link_id, :access_date]
    add_index :access_logs, [:ip_address, :access_date], unique: true
  end
end
