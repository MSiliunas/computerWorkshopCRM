class CreateDiscountsToOrderDetails < ActiveRecord::Migration
  def change
    create_table :discounts_to_order_details do |t|
      t.references :order_detail, index: true, foreign_key: true
      t.references :discount, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
