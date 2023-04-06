class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV["username"], :password => ENV["password"]

  def show
    @products_count = Product.count
    @categories_count = Category.count
    @items_in_stock = Product.sum("quantity")
    @orders_count = Order.count
    @orders_value = Order.sum("total_cents") / 100
  end
end
