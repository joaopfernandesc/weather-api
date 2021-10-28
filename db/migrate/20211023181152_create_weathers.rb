class CreateWeathers < ActiveRecord::Migration[6.0]
  def change
    create_table :weathers do |t|
      t.string :date
      t.integer :lat
      t.integer :lon
      t.string :city
      t.string :state
    end
  end
end
