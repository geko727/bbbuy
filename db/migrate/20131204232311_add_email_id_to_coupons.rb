class AddEmailIdToCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons, :email_id, :integer
  end
end
