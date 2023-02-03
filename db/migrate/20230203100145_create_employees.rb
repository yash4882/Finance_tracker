class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :entry, default: 0
      t.datetime :time

      t.timestamps
    end
  end
end
