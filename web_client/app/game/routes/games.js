'use strict';

//Setting up route
angular.module('eiffel-2048.game').config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {

        $urlRouterProvider.otherwise('/');

        // states for my app
        $stateProvider
            .state('home', {
                url: '/',
                templateUrl: '/app/game/views/view.html',
                resolve: {
                }
            });
    }
]);
