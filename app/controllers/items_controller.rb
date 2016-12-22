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
		flash[:notice] = "Item Added"
		redirect_to new_path
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
		Item.update(params[:item_id], :deleted => true)
		Purchase.where(:item_id => params[:item_id]).update_all(:deleted => true)
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
		@purchases = Purchase.where(:user_id => current_user.id, :deleted => false)
		@deleted = Purchase.where(:user_id => current_user.id, :deleted => true)
	end

  private
  	def item_params
  		params.permit(:item_name, :price, :link, :user_id, :deleted)
  	end

end
