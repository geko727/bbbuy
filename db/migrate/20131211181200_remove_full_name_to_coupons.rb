class RemoveFullNameToCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :full_name, :string
  end
end
