class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.float :price
      t.integer :duration

      t.timestamps null: false
    end

    create_table :order_details_to_tasks do |t|
      t.belongs_to :order, index: true
      t.belongs_to :task, index: true
      t.timestamps null: false
    end
  end
end
