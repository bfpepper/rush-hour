class CreateEvents < ActiveRecord::Migration
  def change
    create_table :event_names do |t|
      t.string :event

      t.timestamps null: false
    end
  end
end
