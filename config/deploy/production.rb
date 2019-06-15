server '94.130.77.166', user: 'deploy', roles: %w[web app db]

set :branch, 'master'

after 'deploy:published', 'delayed_job:restart'
