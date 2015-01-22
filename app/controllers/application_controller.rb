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
  	recipe = {}
		test = doc.css('div#top').map do |element|
			recipe[:title] = element.css()
		end
  	render json: recipe.to_json
  end
end
