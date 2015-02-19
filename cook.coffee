#!/usr/local/bin/coffee
# TODO init template
# TODO post template
## require
fs = require 'fs-extra'
moment = require 'moment'
markdown = require('markdown').markdown
program = require 'commander'
path = require 'path'
yaml = require 'js-yaml'

## alias
_log = console.log
_err = console.error
TEMPLATE_PATH = "#{__dirname}/template"

## version
program.version = require('./package.json').version

## actions
program
  .command 'new [project_name]'
  .description 'create a new blog'
  .action (env, options) ->
    return _err 'Please enter a new project name' if not env
    source = "#{TEMPLATE_PATH}/blog"
    target = env
    fs.copy source, target, (err) ->
      return _err(err) if err
      _log "new [#{target}] blog created!"


##TODO post
# TODO date, title, tag, ...
program
  .command 'post [your awesome post title]'
  .description 'post a new article'
  .action (env, options) ->
    current_dir = path.resolve()
    filename = options.parent.rawArgs[3..].join '-'
    target = "posts/#{filename}.md"
    source = "#{TEMPLATE_PATH}/post/new.md"
    fs.copy source, target, (err) ->
      return _err(err) if err
      _log "file [#{target}] created!"


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
