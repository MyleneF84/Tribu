class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :address
      t.integer :price
      t.date :start_at
      t.date :end_at
      t.integer :number_of_participants
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
