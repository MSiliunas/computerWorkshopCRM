class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :value
      t.string :discount_type
      t.timestamps null: false
    end
  end
end
