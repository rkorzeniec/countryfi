# frozen_string_literal: true

lock '~> 3.14.0'

set :application, 'countrify'
set :repo_url, 'git@github.com:rkorzeniec/countryfier.git'

set :deploy_to, "/var/www/html/apps/#{fetch(:application)}"
set :local_user, 'deploy'

set :keep_releases, 5

append :linked_dirs,
       'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle',
       'public/system', 'public/uploads'
append :linked_files, 'config/database.yml', '.env'
