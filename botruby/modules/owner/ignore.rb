# frozen_string_literal: true

# Copyright Royaloakap
module royaloakap
  module Owner
    royaloakap.crb.add_command(
      :ignore,
      code: proc { |event, args|
        if args == []
          event.respond("#{royaloakap.config['emoji_error']} Mention a valid user!")
          next
        end
        user = Helper.userparse(args[0])

        ignores = begin
          JSON.parse(REDIS.get('ignores'))
        rescue StandardError
          []
        end
        if user.nil?
          event.respond("#{royaloakap.config['emoji_error']} Not a valid user!")
        elsif royaloakap.crb.owner?(user)
          event.respond("#{royaloakap.config['emoji_error']} You can't ignore owners!")
        elsif ignores.include?(user.id)
          event.respond("#{royaloakap.config['emoji_error']} User is already ignored!")
        else
          REDIS.set('ignores', ignores.push(user.id).to_json)
          event.bot.ignore_user(user)
          tickbox = royaloakap.config['emoji_tickbox']
          event.respond("#{tickbox} `#{user.distinct}` is now being ignored!")
        end
      },
      triggers: %w[ignore],
      owners_only: true
    )

    royaloakap.crb.add_command(
      :unignore,
      code: proc { |event, args|
        if args == []
          event.respond("#{royaloakap.config['emoji_error']} Mention a valid user!")
          next
        end

        user = Helper.userparse(args[0])
        ignores = begin
          JSON.parse(REDIS.get('ignores'))
        rescue StandardError
          []
        end

        if user.nil?
          event.respond("#{royaloakap.config['emoji_error']} Not a valid user!")
        elsif !ignores.include?(user.id)
          event.respond("#{royaloakap.config['emoji_error']} User isn't ignored!")
        else
          event.bot.unignore_user(user)
          REDIS.set('ignores', (ignores - [user.id]).to_json)
          tickbox = royaloakap.config['emoji_tickbox']
          event.respond("#{tickbox} `#{user.distinct}` has been removed from the ignore list!")
        end
      },
      owners_only: true
    )
  end
end
