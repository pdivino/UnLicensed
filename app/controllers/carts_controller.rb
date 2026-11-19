class CartsController < ApplicationController
  # Show the cart page: look up each product in the session cart and add up the total.
  def show
    cart = session[:cart] || {}
    products = Product.where(id: cart.keys).with_attached_image.order(:name)

    @items = products.map { |product| { product: product, quantity: cart[product.id.to_s] } }
    @total = @items.sum { |item| item[:product].price * item[:quantity] }
  end

  # Add one of a product to the cart, saved in the session (rubric 3.1.1).
  def add
    product = Product.find(params[:id])

    # The session only stores product IDs and quantities, never prices.
    # Prices always come from the database, so nobody can change what they pay.
    session[:cart] ||= {}
    key = product.id.to_s
    session[:cart][key] = (session[:cart][key] || 0) + 1

    # Custom flash message shown on the next page (rubric 4.2.3).
    flash[:notice] = "#{product.name} was added to your cart."

    # Go back to the page the customer was on.
    redirect_back fallback_location: root_path
  end
end