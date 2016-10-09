class UpdateRequestTypeColumn < ActiveRecord::Migration
  def change
    rename_column :request_types, :request_type, :request
  end
end
