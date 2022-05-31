class AddPhoneNumberEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :phone_number, :string
  end
end
