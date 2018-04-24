(function() {

    angular
        .module('iSiteWatch')
        .controller('DashboardController', DashboardController);

    DashboardController.$inject = ['AuthenticationService', 'UserService', '$location', '$ocLazyLoad', '$filter', '$timeout'];

    function DashboardController(AuthenticationService, UserService, $location, $ocLazyLoad, $filter, $timeout) {
        var dc = this;
        dc.projects = {};
        dc.events = {};
        dc.site_opted = { site_name: "Loading Projects ...", "site_city": null };
        dc.reports = ["Daily Reports", "Equipment Locator", "Management Reports"];
        dc.support = ["Email", "Chat", "800-SiteSup"];
        dc.location_opted = {};

        dc.carousel = $('.owl-carousel').owlCarousel({
            items: 5,
            dots: false,
            autoplay: true,
            loop: true,
            margin: 10,
            autoplay: true,
            autoplayTimeout: 3000,
            autoplayHoverPause: true,
            lazyLoad: true
        });

        var w = $('.history_image').width();
        $('.history_image').height((w / 1.78));

        dc.carousel.on('changed.owl.carousel', function(property) {
            var current = property.item.index;
            var item = $(property.target).find(".item").eq(current);
            $(property.target).find(".item").css('border', '0px solid red');
            $(item).css('border', '3px solid #4388f6');

            var pos = $(item).find("img").attr('pos');
            if (pos && dc.location_history && dc.location_history.length > 0) {
                var rec = dc.location_history[pos];
                $('.history_image').attr('src', rec.image);
                $('.site-hist-name').html(rec.name);
                $('.site-hist-date').html($filter('date')(new Date(rec.timestamp), 'MMM dd, yyyy  HH:mm'));
                $('.site-hist-temp').html(rec.temperature);
                $('.site-hist-humid').html(rec.humidity);
                console.log(JSON.stringify(dc.site_his_rec));
            }
            // console.log('Image position ' + pos);
            //dc.site_his_rec = dc.location_history[pos];
        });

        dc.carousel.on('click', '.item', function(property) {
            var pos = $(property.target).attr('pos');
            var item = $(property.target);
            $('.owl-carousel').find(".item").css('border', '0px solid red');
            $(item).parent().css('border', '3px solid #4388f6');

            if (pos && dc.location_history && dc.location_history.length > 0) {
                var rec = dc.location_history[pos];
                $('.history_image').attr('src', rec.image);
                $('.site-hist-name').html(rec.name);
                $('.site-hist-date').html($filter('date')(new Date(rec.timestamp), 'MMM dd, yyyy  HH:mm'));
                $('.site-hist-temp').html(rec.temperature);
                $('.site-hist-humid').html(rec.humidity);
                console.log(JSON.stringify(dc.site_his_rec));
            }
        });


        dc.showLocations = function() {
            $('.owl-carousel').trigger('stop.owl.autoplay');
            dc.location_history = null;
        };

        dc.showFullImage = function($event) {
            var card = $($event.currentTarget).closest('.card');
            var imgSrc = $(card).find('.history_image').attr('src');
            $('.img-zoom').attr('src', imgSrc);
            $('#myModalLabel').html($(card).find('.site-hist-name').html() + '  <small class="font-weight-300">' + $(card).find('.site-hist-date').html() + '</small>');
            $('#myModal').modal('show');
        };

        dc.toggleContainer = function($event, container) {
            $event.stopPropagation();
            var color = $($event.currentTarget).css('background-color'); //.replace(')', ', 0.1)').replace('rgb(', 'rgba(');
            $($event.currentTarget).closest('.card-footer').attr('style', 'border-top: 2px solid ' + color);
            $($event.currentTarget).closest('.card').find('.location_details').addClass('hide');
            $($event.currentTarget).closest('.card').find('.' + container).toggleClass('hide ');
            $($event.currentTarget).find('i').toggleClass('fa-angle-double-down fa-angle-double-up');
        };

        dc.showLocationHistoryByDate = function($event, imageCal) {
            var data = JSON.parse(JSON.stringify(dc.location_opted));
            data.user_login = dc.user.user_login;
            data.user_token = dc.user.user_token;
            data.to = $filter('date')(imageCal.timestamp, "yyyy-MM-dd");
            data.from = $filter('date')(imageCal.timestamp, "yyyy-MM-dd");
            data.device_id = imageCal.device_id;
            data.location_id = imageCal.location_id;
            $('.owl-carousel').trigger('stop.owl.autoplay');
            dc.location_history = [];

            var loadingEl = $('#locations-history');
            blockUI(loadingEl);
            UserService.GetLocationImagesHistory(data, function(err, imageRecs) {
                unblockUI(loadingEl);
                if (!err) {
                    dc.location_history = imageRecs;

                    var items = $('.owl-carousel').find('.item');
                    for (var i = 0; i < items.length; i++) {
                        $(".owl-carousel").trigger('remove.owl.carousel', [i])
                            .trigger('refresh.owl.carousel');
                    }

                    for (var i in dc.location_history) {
                        $('.owl-carousel').trigger('add.owl.carousel', ['<div class="item"><img pos="' + i + '" src="' + dc.location_history[i].image_thumbnail + '" alt=""></div>']);
                    }
                    $('.owl-carousel').trigger('refresh.owl.carousel');
                    $('.owl-carousel').trigger('play.owl.autoplay', [3000]);

                    //console.log(JSON.stringify(dc.location_history));
                } else {
                    handleError(err);
                }
            });
        };

        dc.showLocationHistory = function($event, location) {
            var data = JSON.parse(JSON.stringify(location));
            data.user_login = dc.user.user_login;
            data.user_token = dc.user.user_token;
            var date1 = new Date();
            var date2 = new Date();
            data.to = $filter('date')(date1, "yyyy-MM-dd");
            date2.setDate(date2.getDate());
            data.from = $filter('date')(date2, "yyyy-MM-dd");

            dc.location_opted = location;
            $('.owl-carousel').trigger('stop.owl.autoplay');
            dc.location_history = [];

            var loadingEl = $('#locations-history');
            blockUI(loadingEl);
            UserService.GetLocationImagesHistory(data, function(err, imageRecs) {
                unblockUI(loadingEl);
                if (!err) {
                    dc.location_history = imageRecs;

                    var items = $('.owl-carousel').find('.item');
                    for (var i = 0; i < items.length; i++) {
                        $(".owl-carousel").trigger('remove.owl.carousel', [i])
                            .trigger('refresh.owl.carousel');
                    }

                    for (var i in dc.location_history) {
                        $('.owl-carousel').trigger('add.owl.carousel', ['<div class="item"><img pos="' + i + '" src="' + dc.location_history[i].image_thumbnail + '" alt=""></div>']);
                    }
                    $('.owl-carousel').trigger('refresh.owl.carousel');
                    $('.owl-carousel').trigger('play.owl.autoplay', [3000]);

                    //console.log(JSON.stringify(dc.location_history));
                } else {
                    handleError(err);
                }
            });

            var dataC = JSON.parse(JSON.stringify(data));
            var date3 = new Date();
            date3.setDate(date3.getDate() - 7);
            dataC.from = $filter('date')(date3, "yyyy-MM-dd");

            UserService.GetLocationImagesCalendar(dataC, function(err, imageRecs) {
                if (!err) {
                    dc.image_calendar = imageRecs;
                } else {
                    handleError(err);
                }
            });

        };

        dc.siteOnClick = function($event, site) {
            dc.site_opted = site;

            var data = {
                "user_login": dc.user.user_login,
                "user_token": dc.user.user_token,
                "site_id": site.site_id,
                "customer_id": site.customer_id
            };

            var loadingEl = $('#locations-container');
            blockUI(loadingEl);
            UserService.GetSiteLocations(data, function(err, locations) {
                unblockUI(loadingEl);
                var dataL = {
                    "user_login": dc.user.user_login,
                    "user_token": dc.user.user_token,
                    "customer_id": site.customer_id
                };

                if (!err) {
                    dc.locations = locations;
                    var arr = [];

                    for (var l in dc.locations) {

                        var locationObj = dc.locations[l];
                        dataL.location_id = locationObj.location_id;
                        arr.push(locationObj.location_id);

                        UserService.GetSiteEvents(dataL, function(err, events, location_id) {
                            dc.events[location_id] = events;
                            console.log('Before Location ' + location_id + ' arr length ' + arr.length);
                            arr.pop(location_id);
                            console.log('Location ' + location_id + ' arr length ' + arr.length);

                            if (arr.length == 0) {
                                $timeout(function() { $('[data-toggle="tooltip"]').tooltip() }, 1000);
                            }

                            //console.log('Location ' + location_id + ' : ' + JSON.stringify(events));
                        });
                    }

                } else {
                    handleError(err);
                }
            });

        };

        dc.showAll = function($event) {
            var el = $($event.currentTarget);
            $(el).find('i').toggleClass('fa-plus fa-minus');
            var t = $(el).find('i').hasClass('fa-plus') ? 'show' : 'hide';

            var ep = $(el).closest('.card').find('.card-footer.' + t).toggleClass('show hide');
            $(el).blur();
            $(el).attr('data-original-title', (t == 'hide') ? 'Hide Location Events' : 'Show Location Events');
        };

        function getProjects() {
            UserService.GetProjects(function(err, rec) {
                dc.user = rec;
                var recs = [rec.customer]; // In future API changes which gives accessible projects or customers.
                for (var p in recs) {
                    var customer_id = recs[p]['customer_id'];
                    var site_id = rec.site_id;
                    dc.projects[customer_id] = { 'name': recs[p]['customer_busname'], 'sites': [] };
                    populateProjectSites({ user_login: rec.user_login, user_token: rec.user_token, customer_id, site_id });
                }
            });
        }

        function populateProjectSites(projectUserData) {
            UserService.GetProjectSites(projectUserData, function(err, sites) {
                if (!err) {
                    dc.projects[projectUserData.customer_id].sites = sites;
                    if (sites.length > 0) {
                        dc.siteOnClick(null, sites[0]);
                    }
                    //console.log(JSON.stringify( dc.projects));
                } else {
                    handleError(err);
                }
            });
        };

        function handleError(err) {
            switch (err.message) {
                case 'TOKEN_EXPIRED':
                    AuthenticationService.ClearCredentials();
                    $location.path('/login');
                    break;
                default:
                    alert('An error occured !');
                    break;
            }
        }

        getProjects();
    }


})();