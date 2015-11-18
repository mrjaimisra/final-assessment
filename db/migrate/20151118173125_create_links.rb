class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.boolean :status
    end
  end
end
