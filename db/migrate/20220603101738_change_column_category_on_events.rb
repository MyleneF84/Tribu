class ChangeColumnCategoryOnEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :category
    add_column :events, :category, :text, array: true, default: []
  end
end
