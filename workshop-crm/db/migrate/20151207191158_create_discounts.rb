class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :value
      t.string :discount_type
      t.timestamps null: false
    end

    create_table :discounts_order_details do |t|
      t.references :discount, index: true, foreign_key: true
      t.references :order_detail, index: true, foreign_key: true
    end
  end
end
