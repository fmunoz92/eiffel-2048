'use strict';

angular.module('eiffel-2048.game').controller('GamesController', ['$scope', '$stateParams', '$location', 'Games', function ($scope, $stateParams, $location, Games) {

    $scope.init = function() {
        var $doc = angular.element(document);

        $doc.on('keydown', $scope.keyPress);

        $scope.$on('$destroy',function(){
            $doc.off('keydown', $scope.keyPress);
        });

        $scope.find();
    }

    $scope.find = function() {
        Games.find()
            .success(function(game) {
                $scope.game = game;
            })
            .error(function(err) {
                console.log('Error: ', err);
            });
    };

    $scope.move = function($direction) {
        Games.move($direction)
            .success(function(game) {
                $scope.game = game;
            })
            .error(function(err){
                console.log('Error: ', err);
            });
    };

    $scope.keyPress = function(keyEvent) {
        var direction = getDirection(keyEvent.which);
        if(direction != null)
            $scope.move(direction);
    }

    function getDirection(keyCode) {
        console.log('keyCode',keyCode)
        var result;

        switch(keyCode) {
            case 38:
                result = "w";
                break;
            case 40:
                result = "s"
                break;
            case 39:
                result = "d"
                break;
            case 37:
                result = "a"
                break;
            default:
                result = null;
        }
        console.log(result);
        return result;
    }
}]);