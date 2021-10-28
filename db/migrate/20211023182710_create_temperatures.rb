class CreateTemperatures < ActiveRecord::Migration[6.0]
  def change
    create_table :temperatures do |t|
      t.decimal :temperature, precision: 3, scale: 1
      t.references :weather
    end
  end
end
