class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index 

  end

  def search
  	search_results = Yummly.search(params[:search])
  	url = search_results.matches[0]["id"]
  	full_url = "http://www.yummly.com/recipe/" + url
  	doc = Nokogiri::HTML(HTTParty.get(full_url))
  	my_recipes = []
    i = 1
    counter = doc.css('ul li.ingredient').length
    while i <= counter do 
      my_recipes.push(
        {
          :amount => doc.css("li.ingredient:nth-child(#{i}) span.amount").text, 
          :name => doc.css("li.ingredient:nth-child(#{i}) strong.name").text,
          :instructions => doc.css("li.ingredient:nth-child(#{i}) span.remainder").text
        }
      )
      i += 1
    end
  	render json: my_recipes.to_json
  end
end
