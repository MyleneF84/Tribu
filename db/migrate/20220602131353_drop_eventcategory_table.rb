class DropEventcategoryTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :event_categories
  end
end
