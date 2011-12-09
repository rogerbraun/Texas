require 'rubygems'
require 'bundler'

Bundler.require

# General Settings
set :views, settings.root + "/app/views"
enable :sessions
set :session_secret, ENV["SESSION_SECRET"] || "MY3qkUGA553tr4fxfov3MeNF1PBw2mvpMsxyiRzBimcJhstWDE6L5IXBCNVzWzemNCQRosCKpn1pLlcp"

# Routes
require_relative "app/routes/index"
require_relative "app/routes/authentication"
require_relative "app/routes/documents"
require_relative "app/routes/files"

# Models
require_relative "app/models/user"
require_relative "app/models/document"

# Helpers
require_relative "app/helpers/authentication.rb"

# Database
require_relative "db/config"

