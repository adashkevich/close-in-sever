class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :event, index: true
      t.integer :count
    end
  end
end
