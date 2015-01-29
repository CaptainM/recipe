module YummlyParser

	def self.parse_search_results(search_results)
		parsed_results = search_results.matches.map do |recipe|
	    recipe_id = recipe["id"]
	    one_recipe = {
	    	:name => recipe["recipeName"],
	    	:image => (recipe["smallImageUrls"][0])[0..-3] << "400"
	    }
	    one_recipe = parse_third_party_data(one_recipe, recipe_id)
	    one_recipe
  	end
	# return the final parsed results for all recipes
		return parsed_results
	end

	def self.parse_third_party_data(recipe, id)
  	full_url = "http://www.yummly.com/recipe/" + id
  	doc = Nokogiri::HTML(HTTParty.get(full_url))
	  third_party = doc.css("button#source-full-directions")[0]["link"]
      
    if third_party.include?("http://")
      recipe[:url] = (third_party[5..-1])
    else
      recipe[:url] = ('//www.yummly.com' + third_party)
    end

	# return a recipe with third party data
		return parse_ingredients(recipe, doc)
	end

	def self.parse_ingredients(recipe, doc)
		ingredient_array = []
    i = 1
    counter = doc.css('ul li.ingredient').length
    while i <= counter do
      ingredient_hash = {
          :amount => doc.css("li.ingredient:nth-child(#{i}) span.amount").text, 
          :ingredient => doc.css("li.ingredient:nth-child(#{i}) strong.name").text,
          :instructions => doc.css("li.ingredient:nth-child(#{i}) span.remainder").text
        }
      ingredient_array.push(ingredient_hash)
      i += 1
    end
    recipe[:ingredients] = ingredient_array
	# return a recipe object with all information
		return recipe
	end

end