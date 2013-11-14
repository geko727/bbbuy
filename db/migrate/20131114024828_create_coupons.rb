class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :serial
      t.timestamp :sent
      t.timestamp :delivered
      t.string :recipient
      t.references :serie, index: true

      t.timestamps
    end
  end
end
