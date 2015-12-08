class OrdersController < ApplicationController
  def new
  end

  def create
    @order = Order.new
  end
end
