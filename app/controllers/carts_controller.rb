class CartsController < ApplicationController
  # Shows the cart page.
  def show
    load_items
  end

  # Adds one of a product to the cart (kept in the session).
  def add
    product = Product.find(params[:id])
    session[:cart] ||= {}
    key = product.id.to_s
    session[:cart][key] = session[:cart].fetch(key, 0).to_i + 1

    redirect_back fallback_location: root_path,
                  notice: "#{product.name} was added to your cart."
  end

  # Changes the quantity of one item.
  def update
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if session[:cart]&.key?(product.id.to_s) && quantity.between?(1, 99)
      session[:cart][product.id.to_s] = quantity
      notice = "#{product.name} quantity updated."
    else
      notice = "Quantity must be a whole number from 1 to 99."
    end

    redirect_to cart_path, notice: notice
  end

  # Removes one item from the cart. This does not depend on the quantity.
  def remove
    product = Product.find(params[:id])
    session[:cart]&.delete(product.id.to_s)

    redirect_to cart_path, notice: "#{product.name} was removed from your cart."
  end

  private

  # Turns the session cart into a list of products and quantities.
  def load_items
    cart = session[:cart] || {}
    products = Product.with_attached_image.where(id: cart.keys).order(:name)
    @items = products.map { |product| { product: product, quantity: cart[product.id.to_s].to_i } }
    @total = @items.sum { |item| item[:product].price * item[:quantity] }
  end
end