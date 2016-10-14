class CreateReferrerIds < ActiveRecord::Migration
  def change
    create_table :referrer_ids do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
