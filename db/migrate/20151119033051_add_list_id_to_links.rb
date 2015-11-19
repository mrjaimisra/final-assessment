class AddListIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :list_id, :integer, default: -1
  end
end
