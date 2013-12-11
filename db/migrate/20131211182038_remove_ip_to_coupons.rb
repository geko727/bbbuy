class RemoveIpToCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :ip, :string
  end
end
