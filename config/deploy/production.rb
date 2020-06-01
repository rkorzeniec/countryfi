# frozen_string_literal: true

server '94.130.77.166', user: 'deploy', roles: %w[web app db]

set :branch, 'master'
set :conditionally_migrate, true

after 'deploy:published', 'delayed_job:restart'
