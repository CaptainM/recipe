App.Views.SearchFormView = Backbone.View.extend({
	el: '#add-form',
	initialize: function() {
		console.log(this);
		this.components = [];
	}, 
	events: {
		'click #add-button': 'addByClick',
		'keypress #add-input': 'addByEnter', 
		'click #search-button': 'search'
	},
	addByClick: function() {
		this.add();
	},
	addByEnter: function(e) {
		console.log(e.which);
		if (e.which === 13) {
			this.add();
		}
	},
	add: function() {
		console.log("add function");
		this.components.push($('#add-input').val());
		this.renderComponent($('#add-input').val());
		console.log(this.components);
		$('#add-input').val("");
	},
	renderComponent: function(ingredient) {
		console.log(ingredient);
		
		this.$el.append($("<div>").text(ingredient).addClass('user_input'));
	},
	search: function() {
		console.log('search function');
		var term = this.components.join(" ");
		console.log(term);
		//add spinner here 
		this.collection.getRecipes(term);
	}
});