class CreatePotatoPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :potato_prices do |t|
      t.datetime :time, null: false
      t.decimal :value, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :potato_prices, :time
  end
end
