'use strict';

// create the module and name it iSiteWatchApp
var iSiteWatchApp = angular.module('iSiteWatchApp', ['ngRoute', 'ngCookies', 'oc.lazyLoad']);

iSiteWatchApp.service('isw_svc', function() { this.location = {}; });

iSiteWatchApp.run(function($rootScope, $cookies, $location) {
    $rootScope.$on("$routeChangeStart", function(event, next, current) {
        if ($cookies.get('user') == null) {
            // no logged user, redirect to /login
            if (next.auth_required)
                $location.path("/login");
        }
    });
});

// configure our routes
iSiteWatchApp.config(function($routeProvider, $httpProvider, $locationProvider) {
    $locationProvider.hashPrefix('');
    $routeProvider
        .when('/', {
            templateUrl: 'main.html',
            controller: 'landingController'
        })
        .when('/login', {
            templateUrl: 'login.html',
            controller: 'loginController'
        })
        .when('/home', {
            templateUrl: 'dashboard.html',
            controller: 'homeController',
            auth_required: true
        })
        .when('/logout', {
            templateUrl: 'main.html',
            controller: 'logoutController'
        })
        .otherwise({ redirectTo: '/' });
});

iSiteWatchApp.controller('loginController', ['$scope', '$cookies', '$http', '$location', function($scope, $cookies, $http, $location) {
    if ($cookies.get('user')) {
        $location.path('/home');
    }

    $scope.authenticate = function() {
        blockUI($('.login-box'));
        var url = "https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/authenticate";
        var data = { user_login: $scope.user_login, user_pass: $scope.user_pass };

        var config = {
            headers: {
                'Content-Type': 'application/json'
            }
        };

        $http.post(url, data, config)
            .then(function mySuccess(response) {
                unblockUI($('.login-box'));
                var response = response.data;
                if (response.status) {
                    if (response.status.code == 200) {
                        $cookies.put('user', JSON.stringify(response.data));
                        $location.path('/home');
                    } else {
                        alert('Authentication failed ...');
                    }
                }
            }, function myError(response) {
                unblockUI($('.login-box'));
            });
    };

}]);

iSiteWatchApp.controller('landingController', function($scope) {
    $scope.message = 'Look! I am an landing page.';
});

iSiteWatchApp.controller('locationHistoryController', ['$scope', '$cookies', '$http', '$routeParams', function($scope, $cookies, $http, $routeParms) {
    var user = JSON.parse($cookies.get('user'));
    var data = $routeParms;
    data.user_login = user.user_login;
    data.user_token = user.user_token;
    data.from = "2018-03-02";
    data.to = "2018-03-03";

    fetchLocationHistory($http, data, $scope);
}]);

iSiteWatchApp.controller('logoutController', function($cookies, $window) {
    logoutUser($cookies);
});

iSiteWatchApp.controller('homeController', ['$scope', '$cookies', '$http', '$location', '$ocLazyLoad', 'isw_svc', function($scope, $cookies, $http, $location, $ocLazyLoad, isw_svc) {
    $scope.site_info = 'Loading ...';
    $scope.nav = -1;
    $scope.location_history = null;
    $scope.reports = ["Daily Reports", "Equipment Locator", "Management Reports"];
    $scope.support = ["Email", "Chat", "800-SiteSup"];
    $scope.isw_svc = isw_svc;

    $scope.toggleLocationInfo = function($event) {
        $($event.currentTarget).closest('.card').find('.list-group').toggleClass('hide ');
        $($event.currentTarget).find('i').toggleClass('fa-angle-double-down fa-angle-double-up');
    };

    $scope.user = JSON.parse($cookies.get('user'));
    $scope.customer = $scope.user.customer;

    fetchAccessibleSites($http, $cookies, $scope);
    $scope.siteOnClick = function(event, site) {
        $scope.nav = 0;
        var data = {
            "user_login": $scope.user.user_login,
            "user_token": $scope.user.user_token,
            "site_id": site.site_id,
            "customer_id": site.customer_id
        };

        $scope.site_name = site.site_name;
        fetchAccessibleLocations(data, $http, $cookies, $scope);
    };

    $scope.locationOnClick = function(event, location) {
        var user = JSON.parse($cookies.get('user'));
        var data = JSON.parse(JSON.stringify(location));
        data.user_login = user.user_login;
        data.user_token = user.user_token;
        data.from = "2018-03-02";
        data.to = "2018-03-03";

        fetchLocationHistory($http, data, $scope, function() {
            $ocLazyLoad.load('/assets/js/wowslider-engine.js');
        });


    };

}]);

function logoutUser($cookies) {
    $cookies.remove('user');
    $('.navbar-brand').trigger('click');
}

function fetchAccessibleLocations(data, $http, $cookies, $scope) {
    blockUI($('#locations-container'));
    var url = "https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/location";
    var config = {
        headers: {
            'Content-Type': 'application/json'
        }
    }
    $http.post(url, data, config)
        .then(function mySuccess(response) {
            var response = response.data;
            if (response.status.code == 200) {
                $scope.locations = response.data;
                unblockUI($('#locations-container'));
            } else {
                alert(response.status.message);
            }

        }, function myError(response) {
            unblockUI($('#locations-container'));
            $cookies.remove('user');
        });
}

function fetchAccessibleSites($http, $cookies, $scope) {
    var url = "https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/site";

    var config = {
        headers: {
            'Content-Type': 'application/json'
        }
    }

    var data = {
        "user_login": $scope.user.user_login,
        "user_token": $scope.user.user_token,
        "site_id": $scope.user.site_id,
        "customer_id": $scope.user.customer_id
    }

    $http.post(url, data, config)
        .then(function mySuccess(response) {
            var response = response.data;
            if (response.status) {
                if (response.status.code == 200) {
                    var data = response.data;
                    $scope.sites_info = data;
                } else {
                    $scope.sites_info = [];
                }
            }
        }, function myError(response) {
            $cookies.remove('user');
        });
}


function fetchLocationHistory($http, data, $scope, cb) {
    $scope.location_history = [];
    blockUI($('#locations-history'));

    var url = "https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/image-history";
    var config = {
        headers: {
            'Content-Type': 'application/json'
        }
    }
    $http.post(url, data, config)
        .then(function mySuccess(response) {
            unblockUI($('#locations-history'));
            var response = response.data;
            if (response.status.code == 200) {
                $scope.location_history = response.data;
                cb();
            } else {
                cb();
                alert(response.status.message);
            }
        }, function myError(response) {
            unblockUI($('#locations-history'));
            $cookies.remove('user');
            cb();
        });
}