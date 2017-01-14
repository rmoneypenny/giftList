class User < ActiveRecord::Base

 attr_accessor :password
 validates_confirmation_of :password
 validates :email, :email_format => {:message => 'is not looking good'}
 validates :password, presence: true
 validates :name, presence: true
 validates_uniqueness_of :email
 before_save :encrypt_password

 def encrypt_password
  self.password_salt = BCrypt::Engine.generate_salt
  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
 end

 def self.authenticate(email, password)
 	user = User.where(email: email).first
 	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
 		user
 	end
 end

def self.cleanup(user_id)
	#pull all of the user's items then mark for deletion
	items = Item.where(user_id: user_id)
	item_id = []
	items.each do |i|
		item_id.push(i.id)
		i.deleted = true
		i.save
	end
	#pull all purchases made on the user's items
	purchases = Purchase.where(item_id: item_id)
	#pull all purchases made by that user
	myPurchases = Purchase.where(user_id: user_id)
	#if there are purchases made on the user's items, mark for deletion
	if !purchases.empty?
		purchases.each do |p|
			p.deleted = true
			p.save
		end
	else
	#if not, destroy the item
		Item.where(user_id: user_id).destroy_all
	end
	#run through the users purchases, delete the purchase then delete the item if it is marked for deletion and there is only 1 purchase
	myPurchases.each do |mp|
		if Item.where(id: mp.item_id).first.deleted == true && Purchase.where(item_id: mp.item_id).count == 1
			Item.where(id: mp.item_id).destroy_all
		end
		mp.destroy
	end


	User.where(id: user_id).destroy_all
end

end