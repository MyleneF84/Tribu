class DropCategoryTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :categories, force: :cascade
  end
end
