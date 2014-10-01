'use strict';

angular.module('eiffel-2048.game')
	.directive('chemicalElement', function() {
		return {
			restrict: 'E',
			scope: {
				value: '=value',
				index: '=index',
				model: '=ngModel'
			},
			replace: true,
			templateUrl: '/app/game/directives/chemical-elements.html',
			link: function(scope, elem, attrs) {
	         	scope.$watch('value', function (newValue, oldValue) {
	                scope.element = getValue(newValue);
	            });

	         	var mapping = {
	         		0: "",
	         		2: "H",
	         		4: "HE",
	         		8: "LI",
	         		16: "BE",
	         		32: "B",
	         		64: "C",
	         		128: "N",
	         		256: "O",
	         		512: "F",
	         		1024: "NE",
	         		2048: "NA",
	         		5096: "MG"
	         	};

	         	function getValue(number) {
	         		return mapping[number];
	         	}

				scope.element = getValue(scope.model);	
			}
		};
	});