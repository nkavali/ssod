$(document).ready(function() {
    $('[data-toggle="tooltip"]').tooltip();
    initCheckBox();
    initRadioGroup();
    initMinMaxInputFields();
    if ($('.login-box').length > 0) {
        var t = $(window).height() / 2 - $('.login-box').height() / 2;
        $('.page-login').css({ 'padding-top': (t / 2) + 'px' });
    }
});

function hasAttr(el, attribute) {
    var attr = $(el).attr(attribute);
    return (typeof attr !== typeof undefined && attr !== false);
}

function initMinMaxInputFields() {
    $("input[type=number]").on('blur', function() {
        var revert = false;

        var min = hasAttr($(this), 'min') ? $(this).attr('min') : null;
        var max = hasAttr($(this), 'max') ? $(this).attr('max') : null;

        if (min && parseFloat($(this).val()) < parseFloat(min)) {
            revert = true;
        }

        if (max && parseFloat($(this).val()) > parseFloat(max)) {
            revert = true;
        }

        if (revert)
            $(this).val('');
    });
}

var JSSession = function() {
    this.get = function(key) {
        var s = window.name;
        if (s == '') {
            return '';
        } else {
            var j = JSON.parse(s);
            return j[key] ? j[key] : '';
        }
    };

    this.set = function(key, val) {
        var s = window.name;
        var j = s == '' ? {} : JSON.parse(s);
        j[key] = val;
        window.name = JSON.stringify(j);
    };

    this.log = function() {
        console.log('JSSession Data ' + window.name);
    };
};

function initCheckBox() {
    var cb = $('.fa-checkbox');
    if (cb) {
        for (var i = 0; i < cb.length; i++) {
            $(cb[i]).addClass('cursor app-color');
            $(cb[i]).off('click').on('click', function() {
                $(this).toggleClass('fa-check-square fa-square-o');
            });
        }
    }
}

function radioOnClick() {
    if ($(this).hasClass('fa-circle-o')) {
        $(this).closest('.radio-group').find('.fa-radio').removeClass('fa-dot-circle-o').addClass('fa-circle-o');
        $(this).toggleClass('fa-dot-circle-o fa-circle-o');
        $(this).trigger('change');
    }
}

function initRadioGroup() {
    var rg = $('.radio-group');
    if (rg) {
        for (var i = 0; i < rg.length; i++) {
            var rs = $(rg[i]).find('.fa-radio');
            $(rs).addClass('cursor app-color');
            $(rs).on('click', radioOnClick);
        }
    }
}

function centerBootbox(b) {
    var wh = $(window).height();
    var dh = $(".modal-dialog").height();
    var h = (wh - dh - 150) / 2;
    $(b).find('.modal-content').attr('style', 'margin-top:' + h + "px");
}

function getElementWH(el) {
    return {
        height: $(el).height(),
        width: $(el).width()
    };
}

function blockUI(item) {
    $(item).block({
        message: '<i class="fa fa-circle-o-notch fa-spin fa-2x fa-fw text-success" aria-hidden="true"></i>',
        css: {
            border: 'none',
            padding: '0px',
            width: '20px',
            height: '20px',
            backgroundColor: 'transparent'
        },
        overlayCSS: {
            backgroundColor: '#fff',
            opacity: 0.9,
            cursor: 'wait'
        }
    });
}

function unblockUI(item) {
    setTimeout(function() {
        $(item).unblock()
    }, 500);
}

function createTooltips(obj, tagname) {
    var tooltips = $(obj).find(tagname + '[tooltip]');
    for (var j = 0; j < tooltips.length; j++) {
        $(tooltips[j]).attr('title', $(tooltips[j]).attr('tooltip'));
        $(tooltips[j]).attr('data-toggle', 'tooltip');
        $(tooltips[j]).removeAttr('tooltip');
    }
}