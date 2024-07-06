# frozen_string_literal: true

# Copyright Royaloakap Arrowsmith 2017

module royaloakap
  module Utility
    royaloakap.crb.add_command(
      :stubs,
      code: proc { |event, _|
        event.respond('This command has been removed!')
      },
      triggers: %w[zalgo command angry space
                   tell randommovie owner dump translate]
    )
  end
end
