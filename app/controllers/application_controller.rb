class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Load the categories before every page, so the top menu can list them.
  before_action :load_menu_categories

  # Makes cart_count usable in views (for the "Cart (3)" link in the menu).
  helper_method :cart_count

  private

  def load_menu_categories
    @menu_categories = Category.order(:name)
  end

  # Total number of items in the cart. The cart lives in session[:cart] as { "product_id" => quantity }.
  def cart_count
    (session[:cart] || {}).values.sum
  end
end