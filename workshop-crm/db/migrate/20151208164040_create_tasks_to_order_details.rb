class CreateTasksToOrderDetails < ActiveRecord::Migration
  def change
    create_table :tasks_to_order_details do |t|
      t.references :order_detail, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
