class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index 

  end

  def search
  	search_results = Yummly.search(params[:search])
    my_recipes = search_results.matches.map do |recipe|
    	url = recipe["id"]
    	full_url = "http://www.yummly.com/recipe/" + url
    	doc = Nokogiri::HTML(HTTParty.get(full_url))
    	one_recipe = []
      recipe_name = recipe["recipeName"]
      one_recipe.push(recipe_name)
      if doc.css("div.yummly-prep-steps ol").length == 1
         one_recipe.push(doc.css("li.prep-step").text)
      else
        third_party = doc.css("button#source-full-directions")[0]["link"]
          if third_party.include?("http://")
            no_Http = (third_party[5..-1])
            if no_Http[-1, 1] == '/'
              one_recipe.push(no_Http.chop)
            else
              one_recipe.push(no_Http)
            end
          else
            one_recipe.push('//www.yummly.com' + third_party)
          end
        end
      i = 1
      counter = doc.css('ul li.ingredient').length
      while i <= counter do 
        one_recipe.push(
          {
            :amount => doc.css("li.ingredient:nth-child(#{i}) span.amount").text, 
            :ingredient => doc.css("li.ingredient:nth-child(#{i}) strong.name").text,
            :instructions => doc.css("li.ingredient:nth-child(#{i}) span.remainder").text
          }
        )
        
        i += 1
      end
      
      {:recipe => one_recipe}

    end
  	render json: {:recipes => my_recipes}.to_json
    

  end

end

# recipes = [
#   [
#     {
#       amount: 'jahsdf'
#     },
#     {
#       amount: 'jhaksdjf'
#     }
#   ],

#   [
#     {
#       amount: 'oqiweru'
#     }
#   ]
# ]
