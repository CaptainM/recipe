class Ingredient < ActiveRecord::Base
	validates_presence_of :ingredient
	validates :quantity, :numericality => true


end