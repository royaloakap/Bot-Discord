# frozen_string_literal: true

# Copyright Royaloakap

module royaloakap
  module Mod
    royaloakap.crb.add_command(
      :unban,
      code: proc { |event, args|
        error = royaloakap.config['emoji_error']

        target_id = args[0]
        # Only one ID should match.
        target_group = event.server.bans.select { |x| x.user.id.to_s == target_id }
        if (target_group == []) || target_group.nil?
          event.respond("#{error} Failed to find ban for user with ID `#{target_id}!`")
          next
        end

        target_user = target_group[0].user

        begin
          event.server.unban(target_user)
        rescue Discordrb::Errors::NoPermission
          event.respond("#{error} I don't have permission to unban #{target_user.name}!")
          next
        end

        event.respond("#{royaloakap.config['emoji_success']} Unbanned #{target_user.name}!")
      },
      max_args: 1,
      server_only: true,
      required_permissions: [:ban_members]
    )
  end
end
