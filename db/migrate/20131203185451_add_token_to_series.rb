class AddTokenToSeries < ActiveRecord::Migration
  def change
  	add_column :series, :token, :string
  	Serie.all.each do |serie|
  		serie.token = SecureRandom.urlsafe_base64
  		serie.save
  	end
  end
end
