(function() {
    'use strict';

    angular
        .module('iSiteWatch')
        .controller('HomeController', HomeController);

    HomeController.$inject = ['UserService', '$rootScope'];

    function HomeController(UserService, $rootScope) {
        var vm = this;
    }

})();