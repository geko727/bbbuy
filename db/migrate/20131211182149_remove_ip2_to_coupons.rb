class RemoveIp2ToCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :ip2, :string
  end
end
