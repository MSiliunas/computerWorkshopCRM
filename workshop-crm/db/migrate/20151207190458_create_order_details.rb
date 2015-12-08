class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :status
      t.belongs_to :order, index: true
      t.references :discount, index: true, foreign_key: true
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
