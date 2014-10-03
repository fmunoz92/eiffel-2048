'use strict';

angular.module('eiffel-2048.user').controller('UsersController', ['$scope', '$stateParams', '$location', 'Users', function ($scope, $stateParams, $location, Users) {

    $scope.init = function() {

    }

    $scope.login = function() {    
        Users.login($scope.name, $scope.password)
            .success(function(response) {
                $scope.successfulLogin=true
            })
            .error(function(err) {
                $scope.successfulLogin=false
            });
    }

    

}]);