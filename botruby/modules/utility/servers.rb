# frozen_string_literal: true

# Copyright Royaloakap A. (Royaloakap.moe) 2019-2020
module royaloakap
  module Utility
    royaloakap.crb.add_command(
      :servers,
      code: proc { |event, _args|
        event.respond "🏠 | I am in **#{event.bot.servers.count}** servers!"
      }
    )
  end
end
