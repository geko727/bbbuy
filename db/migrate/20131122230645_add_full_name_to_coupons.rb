class AddFullNameToCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons, :full_name, :string
  end
end
