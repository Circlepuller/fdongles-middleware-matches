_      = require 'underscore'
assert = require 'assert'

Bot = require 'fdongles'

matches = require '../index'

createBot = ->
  new Bot 'irc.datnode.net', 'TestBot',
   autoConnect: false

emitMessage = (message, bot) ->
  bot.emit 'message', 'user', '#fdongles', message,
    prefix: 'user@example.com'
    nick: 'user'
    user: 'user'
    host: 'user@example.com'
    command: 'PRIVMSG'
    rawCommand: 'PRIVMSG'
    commandType: 'normal'
    args: [ '#fdongles', message ]


describe 'matches', (done) ->
  it 'should restrict message event to only ones that contain hello', (done) ->
    bot = createBot()
    bot.on 'message', matches(/hello/), ->
      done()
    emitMessage 'hello world', bot

  it 'should only match specified messages', ->
    bot = createBot()

    bot.on 'message', matches(/hello/), (user, channel, message) ->
      assert.ok message is 'hello world'

    bot.on 'message', matches(/bird/), (user, channel, message) ->
      assert.ok message is 'fellow bird'

    bot.on 'message', matches('hi world'), (user, channel, message) ->
      assert.ok message is 'hi world'

    emitMessage 'hi world', bot
    emitMessage 'whats up world', bot
    emitMessage 'hello world', bot
    emitMessage 'fellow bird', bot

  it 'should be able to parse a parameter', ->

    bot = createBot()

    bot.on 'message', matches('hello :what'), (user, channel, message, event) ->
      assert.ok event.matches.params.what is 'world'

    emitMessage 'hello world', bot

  it 'should be able to parse multiple parameters', ->
    bot = createBot()
    bot.on 'message', matches('my :key is :value'), (user, channel, message, event) ->
      assert.ok event.matches.params.key is 'name'
      assert.ok event.matches.params.value is 'fdongles'

    emitMessage 'my name is fdongles', bot

describe 'matches.url', ->
  it 'should be able catch an url', (done) ->
    bot = createBot()

    bot.on 'message', matches(matches.url), (user, channel, message, event) ->
      done()

    emitMessage 'https://github.com/medialize/URI.js/blob/gh-pages/src/URI.js', bot



