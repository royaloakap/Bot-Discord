# frozen_string_literal: true

# Copyright Royaloakap
module royaloakap
  module Owner
    royaloakap.crb.add_command(
      :owners,
      code: proc { |event, _|
        event << 'This bot instance is managed/owned by the following users. ' \
                 'If you have any questions or concerns, please DM me or view my help command!'
        unless royaloakap.config['master_owner'].nil?
          event << "- **#{event.bot.user(royaloakap.config['master_owner']).distinct}** [**MAIN**]"
        end
        Helper.owners.each do |x|
          event << if event.bot.user(x).nil?
                     "- Unknown User (ID: `#{x}`)"
                   else
                     "- **#{event.bot.user(x).distinct}**"
                   end
        end
      },
      triggers: ['owners']
    )

    royaloakap.crb.add_command(
      :botowners,
      code: proc { |event, args|
        error = royaloakap.config['emoji_error']
        tickbox = royaloakap.config['emoji_tickbox']

        user = Helper.userparse(args[1])
        if user.nil?
          event.respond("#{error} Not a valid user!")
          next
        end
        case args[0]
        when 'add'
          if royaloakap.crb.owner?(user.id)
            event.respond("#{error} User is already an owner!")
          else
            REDIS.set('owners', Helper.owners.push(user.id).to_json)
            event.respond("#{tickbox} added `#{Helper.userid_to_string(user.id)}` to bot owners!")
          end
        when 'remove'
          if royaloakap.config['master_owner'] == user.id
            event.respond("#{error} You can't remove the main owner!")
          elsif Helper.owners.include?(user.id)
            REDIS.set('owners', (Helper.owners - [user.id]).to_json)
            userid = Helper.userid_to_string(user.id)
            event.respond("#{tickbox} removed `#{userid}` from bot owners!")
          else
            event.respond("#{error} User is not an owner!")
          end
        end
      },
      owners_only: true
    )
  end
end
