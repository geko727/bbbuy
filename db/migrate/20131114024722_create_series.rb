class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
      t.float :value
      t.string :currency

      t.timestamps
    end
  end
end
