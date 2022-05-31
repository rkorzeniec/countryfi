# frozen_string_literal: true

server '116.203.201.175', user: 'deploy', roles: %w[web app db]

set :branch, 'master'
set :conditionally_migrate, true

set :delayed_job_workers, 1
set :delayed_job_service, -> { 'delayed_job' }

after 'deploy:published', 'delayed_job:restart'
