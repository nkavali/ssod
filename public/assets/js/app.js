'use strict';
var iSiteWatchApp = angular.module('iSiteWatch', ['ngRoute', 'ngCookies', 'oc.lazyLoad', '720kb.tooltips']);

// Filter to check session
iSiteWatchApp.run(function($rootScope, $cookies, $location) {
    $rootScope.$on("$routeChangeStart", function(event, next, current) {
        if ($cookies.getObject('globals') == null) {
            // no logged user, redirect to /login
            if (next.auth_required)
                $location.path("/login");
        }
    });
});

// configure our routes
iSiteWatchApp.config(function($routeProvider, $locationProvider) {
    $locationProvider.hashPrefix('');
    $routeProvider
        .when('/', {
            templateUrl: 'modules/home/home.html',
            controller: 'HomeController',
            controllerAs: 'hc'
        })
        .when('/login', {
            templateUrl: 'modules/login/login.html',
            controller: 'LoginController',
            controllerAs: 'lc'
        })
        .when('/dashboard', {
            templateUrl: 'modules/dashboard/dashboard.html',
            controller: 'DashboardController',
            controllerAs: 'dc',
            auth_required: true
        })
        .when('/logout', {
            templateUrl: 'modules/home/home.html',
            controller: 'LogoutController'
        })
        .otherwise({ redirectTo: '/' });
});


iSiteWatchApp.controller('LogoutController', ['AuthenticationService', function(AuthenticationService) {
    AuthenticationService.ClearCredentials();
}]);