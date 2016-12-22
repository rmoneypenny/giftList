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
		p = Purchase.where(:id => params[:purchase]).first
		item = Item.where(:id => p.item_id).first
		p.destroy
		if item.deleted
			item.destroy
		end
		redirect_to mypurchases_path
	end

end
