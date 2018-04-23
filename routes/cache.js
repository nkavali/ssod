var cache = {};

cache.data = {};

cache.clear = function() {
    this.data = {};
};

cache.put = function(k, v) {
    cache.data[k] = v;
};

cache.get = function(k) {
    var d = cache.data[k];
    return (typeof d == 'undefined') ? null : d;
};

cache.dump = function() {
    console.log(JSON.stringify(this.data, null, 4));
}

module.exports = cache;