class PurchasesController < ApplicationController

	def create
		
		@p = Purchase.new
		@p.submit(params[:purchase], params[:p_amount])
		redirect_to mypurchases_path
	end

	def destroy
		p = Purchase.where(:id => params[:purchase]).first
		p.destroy
		redirect_to mypurchases_path
	end

end
