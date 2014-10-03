'use strict';

//Setting up route
angular.module('eiffel-2048.user').config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {
        // states for my app
        $stateProvider
            .state('userpanel', {
                url: '/panel',
                templateUrl: '/app/users/views/users.html',
                resolve: {
                }
            });
    }
]);
