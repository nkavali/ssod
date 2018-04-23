(function() {
    'use strict';

    angular
        .module('iSiteWatch')
        .controller('LoginController', LoginController);

    LoginController.$inject = ['AuthenticationService', '$location'];

    function LoginController(AuthenticationService, $location) {
        this.user = '';
        this.pwd = '';

        (function initController() {
            AuthenticationService.isAuthenticated(function(isYes) {
                if (isYes) {
                    $location.path('/dashboard');
                }
            });
        })();

        this.authenticate = function() {
            var loadingEl = $('.login-box');
            blockUI(loadingEl);
            AuthenticationService.Login(this.user, this.pwd, function(err, rec) {
                unblockUI(loadingEl);
                if (err)
                    console.log(err);

                if (rec.status.code == 200) {
                    AuthenticationService.SetCredentials(rec.data);
                    $location.path('/dashboard');
                }
            });
        }
    }

})();