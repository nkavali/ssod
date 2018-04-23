(function() {
    'use strict';

    angular
        .module('iSiteWatch')
        .factory('AuthenticationService', AuthenticationService);

    AuthenticationService.$inject = ['$http', '$cookies', '$rootScope', '$location'];

    function AuthenticationService($http, $cookies, $rootScope, $location) {
        var service = {};

        service.Login = Login;
        service.SetCredentials = SetCredentials;
        service.GetCredentials = GetCredentials;
        service.ClearCredentials = ClearCredentials;
        service.isAuthenticated = isAuthenticated;

        return service;

        function Login(username, password, callback) {

            $http.post('https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/authenticate', { user_login: username, user_pass: password })
                .then(
                    function success(response) {
                        callback(null, response.data);
                    },
                    function failure(response) {
                        callback(response, null);
                    }
                );

        }

        function SetCredentials(user) {
            //var authdata = Base64.encode(username + ':' + password);

            $rootScope.globals = {
                currentUser: user
            };

            // set default auth header for http requests
            // $http.defaults.headers.common['Authorization'] = 'Basic ' + authdata;

            // store user details in globals cookie that keeps user logged in for 1 week (or until they logout)
            //var cookieExp = new Date(user.token_expiry+7);
            //$cookies.putObject('globals', $rootScope.globals, { expires: cookieExp });
            $cookies.putObject('globals', $rootScope.globals, {});
        }

        function ClearCredentials() {
            $rootScope.globals = {};
            $cookies.remove('globals');
            //$http.defaults.headers.common.Authorization = 'Basic';
        }

        function isAuthenticated(callback) {
            //console.log('GLOBALS >> '+$cookies.getObject('globals'));
            return callback($cookies.getObject('globals') != null);
        }

        function GetCredentials(callback) {
            if ($cookies.getObject('globals')) {
                callback(null, $cookies.getObject('globals').currentUser);
            } else {
                callback(new Error('No user found ...'), null);
            }
        }
    }

})();