class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :status, null: false, default: 0
      t.belongs_to :order, index: true
      t.belongs_to :discount, index: true
      t.belongs_to :employee, index: true
      t.belongs_to :computer, index: true

      t.timestamps null: false
    end
  end
end
