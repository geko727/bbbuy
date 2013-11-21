class AddActiveToSeries < ActiveRecord::Migration
  def change
  	add_column :series, :active, :boolean, default: true
  end
end
