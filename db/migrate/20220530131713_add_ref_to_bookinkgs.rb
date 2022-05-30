class AddRefToBookinkgs < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :event, foreign_key: true
  end
end
