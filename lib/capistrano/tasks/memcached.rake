# frozen_string_literal: true

namespace :memcached do
  %w[start stop restart].each do |command|
    desc "#{command} Memcached"
    task command do
      on roles(:app) do
        within current_path.to_s do
          with rails_env: fetch(:stage).to_s do
            run "sudo service memcached #{command}"
          end
        end
      end
    end
  end
end
