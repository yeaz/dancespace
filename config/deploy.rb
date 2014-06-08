# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, "dancespace"

set :scm, :git
set :repository, "git@github.com:yeaz/dancespace.git"
set :branch, 'master'
set :scm_passphrase, ""

set :user, "ubuntu"

set :rails_env, "production"

set :default_stage, "production"

set :use_sudo, false

set :deploy_via, :copy

server "ec2-54-213-98-65.us-west-2.compute.amazonaws.com", roles: [:app, :web, :db], :primary => true
set :deploy_to, "/var/www/dancespace"
