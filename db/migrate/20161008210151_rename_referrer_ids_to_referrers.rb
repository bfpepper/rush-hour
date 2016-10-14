class RenameReferrerIdsToReferrers < ActiveRecord::Migration
  def change
    rename_table :referrer_ids, :referrers
  end
end
