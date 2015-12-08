class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.text :specs
      t.string :serial
      t.belongs_to :client, index: true

      t.timestamps null: false
    end
  end
end
