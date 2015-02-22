class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index 

  end

  def search
  	search_results = Yummly.search(params[:search])
  	my_recipes = YummlyParser.parse_search_results(search_results)
    valid_recipes = my_recipes.select { |recipe| recipe[:ingredients][0][:amount] != "" if recipe }
    render json: valid_recipes
  end

end

# recipes = [
#  {
#     name: 'jahsdf'
#     url: 'jhaksdjf'
#     ingredients: 
#       [
#         {
#           amount:
#           instructions:
#           name:
#         }
#        ]
#     
#   },
#   {
#     name: 'jahsdf'
#     url: 'jhaksdjf'
#     ingredients: 
#       [
#         {
#           amount:
#           instructions:
#           name:
#         }
#        ]
#     
#   },
#   
# ]
