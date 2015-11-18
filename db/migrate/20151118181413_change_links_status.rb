class ChangeLinksStatus < ActiveRecord::Migration
  def change
    change_column :links, :status, :boolean, :default => false
  end
end
