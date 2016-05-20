var Auth                     = require('girder/auth');
var Events                   = require('girder/events');
var LayoutHeaderUserTemplate = require('girder/templates/layout/layoutHeaderUser.jade');
var Router                   = require('girder/router');
var View                     = require('girder/view');

require('bootstrap/js/dropdown');

/**
 * This view shows the user menu, or register/sign in links if the user is
 * not logged in.
 */
var LayoutHeaderUserView = View.extend({
    events: {
        'click a.g-login': function () {
            Events.trigger('g:loginUi');
        },

        'click a.g-register': function () {
            Events.trigger('g:registerUi');
        },

        'click a.g-logout': Auth.logout,

        'click a.g-my-folders': function () {
            Router.navigate('user/' + Auth.getCurrentUser().get('_id'), {trigger: true});
        },

        'click a.g-my-settings': function () {
            Router.navigate('useraccount/' + Auth.getCurrentUser().get('_id') +
                                   '/info', {trigger: true});
        }
    },

    initialize: function () {
        Events.on('g:login', this.render, this);
        Events.on('g:login-changed', this.render, this);
        Events.on('g:logout', this.render, this);
    },

    render: function () {
        this.$el.html(LayoutHeaderUserTemplate({
            user: Auth.getCurrentUser()
        }));
        return this;
    }
});

module.exports = LayoutHeaderUserView;
