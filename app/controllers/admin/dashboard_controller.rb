class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USER_NAME'], password: ENV['USER_PASSWORD'], only: :show
  def show
    # Display a count of how many products are in the database
    @products_count = Product.all.count
    # Display a count of how many categories are in the database
    @categories_count = Category.all.count
  end
end
