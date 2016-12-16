class Purchase < ApplicationRecord

	def status(item_id)
		if Purchase.exists?(:item_id => item_id)
			difference = self.amountDifference(item_id)
			if difference == 0
				["$" + Item.where(:id => item_id).first.price.to_s, "Yes"]
			else
				["$" + difference.round(2).to_s, "Partial"]
			end
		else
			["$" + Item.where(:id => item_id).first.price.to_s, "No"]
		end
	end

	def submit(purchase, p_amount)
		#purchase = [item_id, user_id, "Full" or "Partial"]
		p = purchase.split(" ")
		difference = self.amountDifference(p[0])
		if p[2] == "Full"
			a = Purchase.create(:item_id => p[0], :user_id => p[1],:amount => difference)
			a.save
		elsif p[2] == "Partial" && difference >= p_amount.to_f
			a = Purchase.create(:item_id => p[0], :user_id => p[1], :amount => p_amount)
			a.save
		end

	end

	def amountDifference(i_id)
		if Purchase.exists?(:item_id => i_id)
			price = (Item.find_by id: i_id).price
			total = Purchase.where(:item_id => i_id).sum(:amount)

			(price.to_f-total.to_f).round(2)
		else
			(Item.find_by id: i_id).price
		end
		#price = 
	end


end
