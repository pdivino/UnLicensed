class ProductsController < ApplicationController
  # Front page: get all products, sorted by name.
  # includes / with_attached_image load categories and images in one go (faster).
  # .page(params[:page]).per(6) = show 6 products per page (Kaminari, rubric 2.5).
  def index
    @products = Product.includes(:category).with_attached_image.order(:name).page(params[:page]).per(6)
  end

  # One product's page. params[:id] is the number in the address, like /products/2.
  def show
    @product = Product.find(params[:id])
  end

  # Search by keyword in the name or description, optionally inside one category (rubric 2.6).
  def search
    @keyword = params[:keyword].to_s.strip
    @products = Product.includes(:category).with_attached_image.order(:name)

    if @keyword.present?
      # sanitize_sql_like escapes special characters like % and _ in what the user typed.
      # The :term placeholder lets Rails insert the text safely (stops SQL injection).
      term = "%#{Product.sanitize_sql_like(@keyword)}%"
      @products = @products.where("products.name LIKE :term OR products.description LIKE :term", term: term)
    end

    # Only filter by category if one was picked. "All categories" sends an empty value.
    if params[:category_id].present?
      @category = Category.find_by(id: params[:category_id])
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).per(6)
  end
end