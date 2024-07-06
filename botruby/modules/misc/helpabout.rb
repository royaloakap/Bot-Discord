# frozen_string_literal: true

# Copyright Royaloakap
module royaloakap
  module Misc
    royaloakap.crb.add_command(
      :help,
      code: proc { |event, _|
        event << "Hello! I am #{event.bot.profile.username} `#{royaloakap.version}`"
        event << if royaloakap.config['show_help']
                   "Follow this link for basic help: ** 🔗 #{royaloakap.config['help_url']}**"
                 else
                   'Unfortunately, no command help can be shown. Please contact the bot owner.'
                 end
        if royaloakap.config['show_support']
          event << "\n You can also join our support server for realtime help: " \
                   "** 🔗 <#{royaloakap.config['support_server']}>**"
        end
        if royaloakap.config['show_invite']
          invite_url = if royaloakap.config['invite_url'] == 'nil'
                         event.bot.invite_url
                       else
                         royaloakap.config['invite_url']
                       end
          event << "\n Or if you're looking to invite me to your server, you can do it here: " \
                   "** 🔗 <#{invite_url}>**"
        end
      },
      triggers: %w[help support commands invite]
    )
  end
end
