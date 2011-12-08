require 'rubygems'
require 'bundler'

Bundler.require

set :views, settings.root + "/app/views"

require_relative "app/routes/index"
