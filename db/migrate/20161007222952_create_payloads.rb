class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.datetime :requested_at
      t.integer :url_id
      t.integer :responded_in
      t.integer :referrer_id
      t.integer :request_type_id
      t.integer :event_name_id
      t.integer :agent_id
      t.integer :screen_resolution_id
      t.integer :ip_id
      t.timestamps null: false
    end
  end
end
