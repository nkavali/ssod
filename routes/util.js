var mathjs = require('mathjs');
var util = {};

util.sortJSON = function(a) {
    var b = {};
    Object.keys(a).sort(function(d, c) { if (d.toLowerCase() < c.toLowerCase()) { return -1 } if (d.toLowerCase() > c.toLowerCase()) { return 1 } return 0 }).forEach(function(c) { b[c] = a[c]; });
    return b;
};

util.prepareMatchPhrases = function(fieldName, valArr) {
    var matchPhrases = [];
    for (var i = 0; i < valArr.length; i++) {
        var obj = { "match_phrase": {} };
        obj['match_phrase'][fieldName] = valArr[i];
        matchPhrases.push(obj);
    }
    return matchPhrases;
};

util.getQuery = function(q) {
    return JSON.parse(JSON.stringify(q));;
};

util.round = function(num) {
    return Math.round(num * 100) / 100;
};

util.covariance = function(arr1, arr2) {
    if (arr1.length == arr2.length) {
        var m1 = mathjs.mean(arr1);
        var m2 = mathjs.mean(arr2);

        var xy = 0;
        for (var i = 0; i < arr1.length; i++) {
            xy += ((arr1[i] - m1) * (arr2[i] - m2));
        }
        return xy / (arr1.length - 1);
    } else {
        console.log('arr1 and arr2 are of not same length');
        return 0;
    }
};

module.exports = util;