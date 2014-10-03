'use strict';

//Games service used for game REST endpoint
angular.module('eiffel-2048.user').factory('Users', ['$http', 'Global', function($http, Global) {
	var host = Global.host
    return {
    	login: function(name, password) {
    		return $http.post(host + "login&name="+name+"&password="+password);
    	},
    	signup: function(name, password) {
    		return $http.post(host + "login&name="+name+"&password="+password);
    	}
    }
}]);