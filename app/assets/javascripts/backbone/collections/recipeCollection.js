App.Collections.RecipeCollection = Backbone.Collection.extend({
	model: App.Models.Recipe,
	initialize: function() {
		console.log("A collection is created");
	},
	url: '/', 
	getRecipes: function(term) {
		this.fetch({
			url: this.url + 'search',
			data: {search: term},
			reset: true,
			success: function(col, data) {
				debugger;
			}
		});
	}
});
