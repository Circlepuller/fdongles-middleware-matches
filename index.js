var matches, routes,
  __slice = [].slice;

routes = require('routes');

matches = function(pattern) {
  var router;
  router = routes();
  router.addRoute(pattern, function() {});
  return function() {
    var args, event, next, text, _i;
    args = 4 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 3) : (_i = 0, []), text = arguments[_i++], event = arguments[_i++], next = arguments[_i++];
    if ((event.matches = router.match(text)) == null) {
      return;
    }
    if (this.opt.debug) {
      this.info("Matched \"" + pattern + "\" with \"" + text + "\"");
    }
    return next();
  };
};

matches.url = /\b((?:[a-z][\w-]+:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/ig;

module.exports = matches;
