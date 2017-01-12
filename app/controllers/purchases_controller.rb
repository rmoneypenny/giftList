class PurchasesController < ApplicationController

	def create
		
		@p = Purchase.new
		if params[:purchase]
			@p.submit(params[:purchase], params[:p_amount])
			redirect_to mypurchases_path
		else
			flash[:notice] = "Item not purchased. Please select Full or Partial when submitting"
			redirect_to others_path
		end
	end

	def destroy
		
		myPurchase = Purchase.where(:id => params[:purchase]).first
		puts myPurchase.item_id
		allPurchases = Purchase.where(:item_id => myPurchase.item_id)
		puts allPurchases.count

		if allPurchases.count == 1
			myPurchase.destroy
			item = Item.where(:id => myPurchase.item_id).first
			if item.deleted
				item.destroy
			end
		else
			myPurchase.destroy
		end
		redirect_to mypurchases_path
	end

end
