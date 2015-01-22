App.Views.SearchFormView = Backbone.View.extend({
	el: '#add-form',
	initialize: function() {
		console.log(this);
		this.components = [];
		// this.template = HandlebarsTemplates['component'];
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
		//this.template{name: ingredient};
		console.log(ingredient);
		this.$el.append($("<div>").text(ingredient));
	},
	search: function() {
		console.log('search function');
		//$.ajax
		var term = this.components.join(" ");
		console.log(term);
		this.collection.getRecipes(term);
	}
});