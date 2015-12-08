class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :client, index: true
      t.references :order_detail, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
