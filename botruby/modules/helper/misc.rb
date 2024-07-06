# frozen_string_literal: true

# Copyright Royaloakap

module royaloakap
  module Helper
    def self.isadmin?(member)
      Commandrb.owners.include?(member)
    end

    def self.quit(status = 0)
      puts 'Exiting...'
      begin
        royaloakap.crb.bot.stop
      rescue StandardError
        royaloakap.crb.bot.invisible
      end
      exit(status)
    end

    def self.ctrl_c(type)
      puts "[WARN] #{type} detected, safely shutting down...."
      royaloakap.crb.bot.stop
      exit(0)
    end
    trap('SIGINT') { ctrl_c('SIGINT') }
    trap('SIGTERM') { ctrl_c('SIGTERM') }

    def self.role_from_name(server, rolename)
      server.roles.select { |r| r.name == rolename }.first
    end

    # Get the user's color
    def self.colour_from_user(member, default = -1)
      return default if member.nil? || !member.is_a?(Discordrb::Member)

      color = default
      unless member.nil?
        member.roles.sort_by(&:position).reverse.each do |role|
          next if role.color.combined.zero?

          begin
            puts "Using #{role.name}'s color #{role.color.combined}" if royaloakap.config['debug']
          rescue StandardError
            nil
          end
          color = role.color.combined
          break
        end
      end
      color
    end
  end
end
