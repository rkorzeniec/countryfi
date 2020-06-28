# frozen_string_literal: true

module Countries
  class DataUpdater
    def initialize(path)
      @source_data = YAML.load_file(path)
    end

    def call
      update_countries
    end

    private

    attr_reader :source_data

    def update_countries
      source_data.each do |data|
        update_country(data)
      end
    end

    def update_country(data)
      Countries::Updater.new(data).call
    end
  end
end
