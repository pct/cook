## command
program = require 'commander'
yaml = require 'js-yaml'
moment = require 'moment'
markdown = require('markdown').markdown
fs = require 'fs-extra'

_log = console.log
_err = console.error

program.version '0.0.1'

##TODO new
program
  .command 'new [project_name]'
  .description 'create a new blog'
  .action (env, options) ->
    source = 'lib/template' # TODO full path?
    target = env
    fs.copy source, target, (err) ->
      return _err(err) if err
      _log "new [#{env}] created!"


##TODO post
# TODO date, title, tag, ...
program
  .command 'post [title]'
  .description 'post a new article'
  .action (env, options) ->
    _log env

##TODO build
program
  .command 'build'
  .description 'build static files'
  .action (env, options) ->
    _log env

##TODO serve
program
  .command 'serve'
  .description 'serve your blog'
  .action (env, options) ->
    _log env

program.parse process.argv
