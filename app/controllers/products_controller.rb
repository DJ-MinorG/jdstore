class ProductsController < ApplicationController
  before_filter :validate_search_key, only: [:search]

  def index
    @products=Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product=Product.find(params[:id])
    if @product.quantity != 0
      current_cart.add_product_to_cart(@product)
      redirect_to :back
    else
      flash[:alert]="暂时缺货，请选购其它商品！"
      redirect_to :back
    end
  end

  def search
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(distinct:true)
      @products = search_result
    end
  end

  def validate_search_key
    @query_string = params[:query_string].gsub(/\\|\'|\/|\?/, '') if params[:query_string].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { title_or_description_cont: query_string }
  end


end
