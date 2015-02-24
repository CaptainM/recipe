require 'rails_helper'

describe YummlyParser do 
	describe "#parse_search_results" do 
		let(:results) do 
			search=Yummly.search("chicken")
			YummlyParser.parse_search_results(search)
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