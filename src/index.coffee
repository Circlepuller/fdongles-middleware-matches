routes = require 'routes'

matches = (pattern) ->
  router = routes()

  router.addRoute pattern, ->

  (args..., text, event, next) ->
    return unless (event.matches = router.match text)?
    @info "Matched \"#{pattern}\" with \"#{text}\"" if @opt.debug
    next()

matches.url = /\b((?:[a-z][\w-]+:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/ig

module.exports = matches
