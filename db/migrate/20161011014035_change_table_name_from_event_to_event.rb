class ChangeTableNameFromEventToEvent < ActiveRecord::Migration
  def change
    rename_table :event_names, :events
  end
end
