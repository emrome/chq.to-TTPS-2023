class CreateAccessLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :access_logs do |t|
      t.string :ip_address, null: false
      t.date :access_date, null: false
      t.references :link, null: false, foreign_key: true
    end
  end
end
