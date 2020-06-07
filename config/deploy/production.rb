# frozen_string_literal: true

server '78.47.203.108', user: 'deploy', roles: %w[web app db]

set :branch, 'master'
set :conditionally_migrate, true

after 'deploy:published', 'delayed_job:restart'
