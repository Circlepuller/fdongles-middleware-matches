routes = require 'routes'

module.exports = (pattern) ->
  router = routes()

  router.addRoute pattern, ->

  (args..., text, event, next) ->
    if (event.matches = router.match text)?
      @info "Matched \"#{pattern}\" with \"#{text}\"" if @opt.debug

      next()
