App.Views.RecipeList = Backbone.View.extend({
	el: '#ingredients',
	initialize: function() {
		console.log("new list view created");
		this.listenTo(this.collection, 'reset', this.addAll);
	},
	addAll: function() {
		this.collection.each(this.renderOneRecipe, this);
	},
	renderOneRecipe: function(recipe) {
		console.log('sup')
		var recipeView = new App.Views.Recipe({model: recipe});
		recipeView.$el.appendTo(this.$el);
	}
})