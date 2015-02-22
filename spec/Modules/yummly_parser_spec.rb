require 'rails_helper'

describe YummlyParser do 
	describe "#parse_search_results" do 
		let(:results) do 
			# search=Yummly.search("chicken")
			# YummlyParser.parse_search_results(search)
			[{:name=>"Unbelievable Chicken",
  :image=>
   "http://lh4.ggpht.com/jlsLgMhtBDw-FOxbgk2f7SHL4liUhzppHtKHujvoquWOYUHD71U8IbdtfWqn0yTMQrGZLn2gvmlf0rjoy3bSYQ=s400",
  :url=>"//allrecipes.com/Recipe/unbelievable-chicken/detail.aspx",
  :ingredients=>
   [{:amount=>"1/4 cup ", :ingredient=>"cider vinegar ", :instructions=>""},
    {:amount=>"3 tbsps ",
     :ingredient=>"ground mustard ",
     :instructions=>"prepared coarse-"},
    {:amount=>"3 cloves ",
     :ingredient=>"garlic ",
     :instructions=>"peeled and minced"},
    {:amount=>"1  ", :ingredient=>"lime ", :instructions=>"juiced"},
    {:amount=>"1/2  ", :ingredient=>"lemon ", :instructions=>"juiced"},
    {:amount=>"1/2 cup ", :ingredient=>"brown sugar ", :instructions=>""},
    {:amount=>"11/2 tsps ", :ingredient=>"salt ", :instructions=>""},
    {:amount=>"  ",
     :ingredient=>"ground black pepper ",
     :instructions=>"to taste"},
    {:amount=>"6 tbsps ", :ingredient=>"olive oil ", :instructions=>""},
    {:amount=>"", :ingredient=>"", :instructions=>""}]}]
		end

		it "returns an array" do
			expect(results).to be_a Array
		end

		it "returns a hash with a name, imgae, url, and ingredients" do 
			expect(results[0][:name]).to_not be_nil
			expect(results[0][:url]).to_not be_nil
			expect(results[0][:image]).to_not be_nil
			expect(results[0][:ingredients]).to_not be_nil
		end

		it "returns recipes with and array of ingredients" do
			expect(results[0][:ingredients]).to be_a Array
		end

		it "ingredients array have ingredient" do
			expect(results[0][:ingredients][0][:ingredient]).to_not be_nil
		end

	end
end