class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @order.build_order_detail
  end

  def create
    @order = Order.new(order_params)
    @order.build_order_detail

    logger.debug @order.order_detail.inspect

    if @order.save
      redirect_to @order
    else
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(order_detail_attributes: [:id, :employee, :computer, :tasks, :discount])
    end
end
