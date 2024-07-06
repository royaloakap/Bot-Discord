# frozen_string_literal: true

# Copyright Royaloakap A 2019-2020
module royaloakap
  module Helper
    # Relatively simple, but repeated in a lot of places.
    def self.owners
      JSON.parse(REDIS.get('owners'))
    rescue StandardError
      []
    end
  end
end
