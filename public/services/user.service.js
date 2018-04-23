(function() {
    'use strict';

    angular
        .module('iSiteWatch')
        .factory('UserService', UserService);

    UserService.$inject = ['$http', 'AuthenticationService'];

    function UserService($http, AuthenticationService) {
        var service = {};

        service.GetProjects = GetProjects;
        service.GetProjectSites = GetProjectSites;
        service.GetSiteLocations = GetSiteLocations;
        service.GetSiteEvents = GetSiteEvents;
        service.GetLocationImagesHistory = GetLocationImagesHistory;
        service.GetLocationImagesCalendar = GetLocationImagesCalendar;

        return service;

        function GetProjects(callback) {
            AuthenticationService.GetCredentials(function(err, user) {
                if (err) {
                    callback(new Error('Credentials missing ...'), null);
                } else {
                    callback(null, user);
                }
            });
        }


        function GetProjectSites(data, callback) {
            $http.post('https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/site', data)
                .then(
                    function success(response) {
                        handleSuccess(response, callback);
                    },
                    function failure(response) {
                        handleError(response, callback);
                    }
                );
        }

        function GetSiteLocations(data, callback) {
            $http.post('https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/location', data)
                .then(function success(response) {
                        handleSuccess(response, callback);
                    },
                    function failure(response) {
                        handleError(response, callback);
                    });
        }

        function GetSiteEvents(data, callback) {
            var location_id = data.location_id;
            $http.post('https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/event/' + location_id, data)
                .then(function success(response) {
                        handleSuccess(response, callback, location_id);
                    },
                    function failure(response) {
                        handleError(response, callback);
                    });
        }


        function GetLocationImagesHistory(data, callback) {
            $http.post('https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/image-history', data)
                .then(function success(response) {
                        handleSuccess(response, callback);
                    },
                    function failure(response) {
                        handleError(response, callback);
                    });
        }

        function GetLocationImagesCalendar(data, callback) {
            data.image_calendar = true;
            $http.post('https://wejllcr10k.execute-api.us-east-1.amazonaws.com/BETA/image-history', data)
                .then(function success(response) {
                        handleSuccess(response, callback);
                    },
                    function failure(response) {
                        handleError(response, callback);
                    });
        }


        // private functions

        function handleSuccess(res, callback) {
            var args = Array.prototype.splice.call(arguments, 2);
            var response = res.data;

            switch (response.status.code) {
                case 200:
                    var argsNew = [null, response.data ? response.data : []];
                    argsNew = argsNew.concat(args);
                    callback.apply(null, argsNew);
                    break;
                case 201:
                    var argsNew = [new Error(response.status.message), null];
                    argsNew = argsNew.concat(args);
                    callback.apply(null, argsNew);
                    break;
                default:
                    var argsNew = [new Error('An error occured ...'), null];
                    argsNew = argsNew.concat(args);
                    callback.apply(null, argsNew);
                    break;
            }
        }

        function handleError(error, callback) {
            callback(error, null);
        }
    }

})()