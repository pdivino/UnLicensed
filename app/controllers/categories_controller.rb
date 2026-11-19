class CategoriesController < ApplicationController
  # One category's page, like /categories/1 (rubric 2.2).
  # Shows only the products in that category, 6 per page.
  def show
    @category = Category.find(params[:id])
    @products = @category.products.with_attached_image.order(:name).page(params[:page]).per(6)
  end
end