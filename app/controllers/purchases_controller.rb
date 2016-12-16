class PurchasesController < ApplicationController

	def create
		
		@p = Purchase.new
		@p.submit(params[:purchase], params[:p_amount])
		redirect_to mypurchases_path
	end

end
