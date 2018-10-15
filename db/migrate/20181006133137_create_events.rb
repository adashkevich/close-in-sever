class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :category, null: false
      t.st_point :location, geographic: true, null: false
      t.boolean :hidden, default: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.decimal :cost
      t.integer :capacity

      t.timestamps
    end
  end
end
