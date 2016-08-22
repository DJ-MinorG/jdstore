module SearchHelper
  def render_highlight_content(product,query_string)
   excerpt_cont = excerpt(product.title, query_string, radius: 50)
   highlight(excerpt_cont, query_string)
 end

end
