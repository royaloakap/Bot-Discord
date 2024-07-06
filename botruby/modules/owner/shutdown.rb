# frozen_string_literal: true

# Copyright Royaloakap
module royaloakap
  module Owner
    royaloakap.crb.add_command(
      :shutdown,
      code: proc { |event, _|
        event.bot.invisible
        event.respond('Goodbye!')
        Helper.quit(0)
      },
      triggers: ['shutdown', 'bye', 'die', 'go away'],
      owners_only: true,
      description: 'Shuts down the bot. Owner only.',
      catch_errors: false
    )

    royaloakap.crb.add_command(
      :reboot,
      code: proc { |event, _|
        event.respond 'Restarting...!'
        Helper.quit(1)
      },
      triggers: ['reboot', 'restart', 'reload', 'gtfo', 'machine 🅱roke', '🅱achine 🅱roke'],
      owners_only: true,
      description: 'Shuts down the bot. Owner only.',
      catch_errors: false
    )
  end
end
