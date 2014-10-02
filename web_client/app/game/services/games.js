'use strict';

//Games service used for game REST endpoint
angular.module('eiffel-2048.game').factory('Games', ['$http', 'Global', function($http, Global) {
	var host = Global.host
    return {
    	find: function() {
    		return $http.post(host);
    	},
    	move: function(direction) {
    		return $http.post(host + direction);
    	}
    }
}]);