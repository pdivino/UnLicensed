class OrdersController < ApplicationController
  before_action :load_cart_items, only: [ :new, :create ]
  before_action :require_items, only: [ :new, :create ]

  # Shows the address form.
  def new
    @customer = Customer.new
    @provinces = Province.order(:name)
  end

  # Saves the customer and the order, then shows the invoice.
  def create
    @customer = Customer.new(customer_params)
    @provinces = Province.order(:name)

    ActiveRecord::Base.transaction do
      @customer.save!
      @order = build_order(@customer)
      @order.save!
    end

    session[:cart] = {}
    session[:last_order_id] = @order.id
    redirect_to order_path(@order), notice: "Thank you! Your order was placed."
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  # The invoice page.
  def show
    @order = Order.includes(order_items: :product).find_by(id: params[:id])

    # Only the person who just placed the order can see its invoice.
    if @order.nil? || session[:last_order_id] != @order.id
      redirect_to root_path, alert: "Invoice not found."
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :city, :postal_code, :province_id)
  end

  # Turns the session cart into a list of products and quantities.
  def load_cart_items
    cart = session[:cart] || {}
    products = Product.where(id: cart.keys)
    @items = products.map { |product| { product: product, quantity: cart[product.id.to_s].to_i } }
    @subtotal = @items.sum { |item| item[:product].price * item[:quantity] }
  end

  def require_items
    redirect_to cart_path, alert: "Your cart is empty." if @items.empty?
  end

  # Builds the order with its items, copying prices and tax rates.
  def build_order(customer)
    province = customer.province
    gst = (@subtotal * province.gst).round(2)
    pst = (@subtotal * province.pst).round(2)
    hst = (@subtotal * province.hst).round(2)

    order = Order.new(
      customer: customer, status: "new", subtotal: @subtotal,
      gst_rate: province.gst, pst_rate: province.pst, hst_rate: province.hst,
      gst_amount: gst, pst_amount: pst, hst_amount: hst,
      total: @subtotal + gst + pst + hst
    )

    @items.each do |item|
      order.order_items.build(
        product: item[:product], quantity: item[:quantity], unit_price: item[:product].price
      )
    end
    order
  end
end