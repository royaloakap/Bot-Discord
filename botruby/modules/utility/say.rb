# frozen_string_literal: true

# Copyright Royaloakap
module royaloakap
  module Utility
    royaloakap.crb.add_command(
      :say,
      code: proc { |event, args|
        message = args.join(' ')
        event.respond(Helper.filter_everyone(message))
      },
      triggers: %w[say echo talk repeat],
      min_args: 1,
      owners_only: true
    )

    royaloakap.crb.add_command(
      :speak,
      code: proc { |event, args|
        event.message.delete
        event.respond(args.join(' '))
      },
      owners_only: true,
      min_args: 1,
      triggers: %w[speak hide]
    )

    # The choose command does not require extra_commands to be enabled.
    royaloakap.crb.add_command(
      :choose,
      code: proc { |event, args|
        event.respond("I choose #{args.sample}!")
      },
      min_args: 1
    )
  end
end
