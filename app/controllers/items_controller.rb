class ItemsController < ApplicationController

	
	def show
		@item = Item.new
		@delete = params[:delete]
		@id = params[:item_id]
	end

	def create
		@item = Item.new(item_params)
		@item.save
		puts @item.id
		redirect_to mylist_path
	end

	def edit
		@item = Item.new
		@item = @item.userList(nil,params[:item_id])[0]
	end

	def update
		
		Item.update(params[:item_id], :item_name => params[:item_name], :price => params[:price], :link => params[:link])
		redirect_to mylist_path
	end

	def destroy
		@item = Item.find(params[:item_id])
		@item.destroy
		redirect_to mylist_path
	end

	def others
		@items = Item.new
		@name = User.new
		@purchase = Purchase.new
	end

	def purchases
		@item = params[:items]
		@purchase = Purchase.new
		@contribute = Purchase.where(:item_id => params[:items])
	end

	def mypurchases
		@purchases = Purchase.where(:user_id => current_user.id)
	end

  private
  	def item_params
  		params.permit(:item_name, :price, :link, :user_id)
  	end

end
