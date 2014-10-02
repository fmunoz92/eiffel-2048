'use strict';

angular.element(document).ready(function() {
    //Fixing facebook bug with redirect
    if (window.location.hash === '#_=_') window.location.hash = '#!';

    //Then init the app
    angular.bootstrap(document, ['eiffel-2048']);
});

// Dynamically add angular modules declared by packages
var packageModules = [];
for (var index in window.modules) {
    angular.module(window.modules[index].module, (window.modules[index].angularDependencies?window.modules[index].angularDependencies:[]));
    packageModules.push(window.modules[index].module);
}

// Default modules
var modules = ['ngResource', 'ui.bootstrap', 'ui.router', 'eiffel-2048.game'];

modules = modules.concat(packageModules);

// Combined modules
angular.module('eiffel-2048', modules);