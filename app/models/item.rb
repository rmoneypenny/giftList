class Item < ApplicationRecord
	belongs_to :user
	has_many :purchases

	def userList(user_id=nil, item_id=nil)
		if user_id
			items = Item.where(:user_id => user_id, :deleted => false)
		else
			items = Item.where(:id => item_id, :deleted => false)
		end
		s = []
		items.each do |i|
			s.push([i.item_name, i.price, i.link, i.id, i.user_id])
		end
		s
	end

	def othersList(nameID)
		names = User.pluck("DISTINCT id")
		names.delete(nameID)
		items = []
		names.each do |n|
			items.push(self.userList(n))
		end
		list = []
		items.each do |i|
			i.each do |j|
				list.push(j)
			end
		end
		list
	end

end
