App.Views.Recipe = Backbone.View.extend({
	tagName: 'section',
	className: 'results',
	initialize: function() {
		console.log("new recipe view");
		this.template = HandlebarsTemplates['recipe'];
		this.render();
	},
	render: function() {
		console.log(this.model.toJSON());
		this.$el.html(this.template(this.model.toJSON()));
	},
	events: {
		'click button.view': 'showModal'
	},
	showModal: function() {
		console.log($('button.view').data("iframeurl"));
	
		var iframeurl = $('button.view').data("iframeurl");
		App.modal.setUrl(iframeurl);
		App.modal.setRecipe(this.model);
		App.modal.show();
	}
})