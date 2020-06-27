# frozen_string_literal: true

module Countries
  module UpdaterLogger
    def log_update(object, columns = [])
      Rails.logger.info(
        "#{object.class}: #{object.previous_changes.slice(*columns)}"
      )
    end
  end
end
