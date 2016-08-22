class SearchController < ApplicationController
    before_filter :validate_search_key, only: [:search]

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
