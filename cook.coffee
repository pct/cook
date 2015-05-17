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
_ = require('underscore')._

## alias
_log = console.log
_err = console.error
TEMPLATE_PATH = "#{__dirname}/template"

## version
version = require('./package.json').version
program.version version

## libs

_capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.substring(1).toLowerCase()

_render_post = (file, data) ->
  tpl = fs.readFileSync file, 'utf-8'
  render = _.template tpl
  fs.writeFile file, render(data), (err) ->
    return _err(err) if err

## actions
# new
program
  .command 'new [project_name]'
  .description 'create a new blog'
  .action (env, options) ->
    return _err 'Please enter a new project name' if not env
    source = "#{TEMPLATE_PATH}/blog"
    target = env
    fs.copy source, target, (err) ->
      return _err(err) if err
      _log "'#{target}' blog created!"


# post
program
  .command 'post [your awesome post title]'
  .description 'post a new article'
  .action (env, options) ->
    current_dir = path.resolve()
    title = options.parent.rawArgs[3..].join ' '
    filename = options.parent.rawArgs[3..].join '-'
    target = "posts/#{filename}.md"
    source = "#{TEMPLATE_PATH}/post/new.md"
    fs.copy source, target, (err) ->
      return _err(err) if err
      _render_post target, {title: _capitalize(title), date: moment().format('YYYY-MM-DD')}
      _log "'#{target}' created!"


##TODO build
# TODO the build dir and check build root
# TODO check if config.yml here
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
