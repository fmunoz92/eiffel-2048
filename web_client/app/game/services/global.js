'use strict';

//Global service for global variables
angular.module('eiffel-2048.game').factory('Global', [
    function() {
        var _this = this;
        _this._data = {
        	host: 'http://localhost:9999?q='
        };
        return _this._data;
    }
]);