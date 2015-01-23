App.Views.Recipe = Backbone.View.extend({
	tagName: 'section',
	className: 'results',
	initialize: function() {
		console.log("new recipe view");
		this.template = HandlebarsTemplates['recipe'];
		this.render();
	},
	render: function() {

		this.$el.html(this.template(this.model.toJSON()));

	}
})