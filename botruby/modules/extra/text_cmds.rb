# frozen_string_literal: true

# Copyright Royaloakap A. (Royaloakap.moe), spotlight_is_ok, Larsenv 2017-2020
module royaloakap
  module Extra
    # Extra commands that are text-based.
    if royaloakap.config['extra_commands']
      text_joke_commands = %w[doit pun wisdom lawyerjoke]
      text_joke_commands.each do |x|
        royaloakap.crb.add_command(
          x.to_sym,
          code: proc { |event|
            result = File.readlines("text/Jokes/#{x}.txt").sample.chomp

            event.respond("\\*#{result}*")
          }
        )
        puts "Added jokes command for #{x}!" if royaloakap.config['verbose']
      end

      text_other_commands = %w[vote topicchange fortunes factdiscord randomssmash4item]
      text_other_commands.each do |x|
        royaloakap.crb.add_command(
          x.to_sym,
          code: proc { |event|
            result = File.readlines("text/Other/Text/#{x}.txt").sample.chomp

            event.respond("\\*#{result}*")
          }
        )
        puts "Added jokes command for #{x}!" if royaloakap.config['verbose']
      end

      royaloakap.crb.add_command(
        :confucious,
        code: proc { |event, _|
          response = File.readlines('text/Jokes/confucious.txt').sample.chomp
          event.respond("Confucious say #{response}")
        }
      )
      puts 'Added jokes command for confucious!' if royaloakap.config['verbose']

      text_attack_commands = %w[nk]
      text_attack_commands.each do |x|
        royaloakap.crb.add_command(
          x.to_sym,
          code: proc { |event|
            result = File.readlines("text/Attack/Text/#{x}.txt").sample.chomp

            event.respond("\\*#{result}*")
          }
        )
        puts "Added attack command for #{x}!" if royaloakap.config['verbose']
      end

      text_attack_commands = %w[lart insult]
      text_attack_commands.each do |x|
        royaloakap.crb.add_command(
          x.to_sym,
          code: proc { |event, args|
            result = File.readlines("text/Attack/Text/#{x}.txt").sample.chomp
            if /{user}/ =~ result
              result = result.gsub('{user}', Extra.calculate_mention(event, args))
            end

            event.respond("\\*#{result}*")
          }
        )
        puts "Added attack command for #{x}!" if royaloakap.config['verbose']
      end

      royaloakap.crb.add_command(
        :bookpun,
        code: proc { |event, _|
          title, author = File.readlines('text/Jokes/bookpun.txt').sample.chomp.split ': ', 2
          event.respond("#{title} by #{author}")
        }
      )
      puts 'Added jokes command for bookpun!' if royaloakap.config['verbose']

      royaloakap.crb.add_command(
        :eightball,
        code: proc { |event, _|
          result = File.readlines('text/Other/8ball_responses.txt').sample.chomp
          event.respond("shakes the magic 8 ball... **#{result}**")
        }
      )
      puts 'Added fun command for eightball!' if royaloakap.config['verbose']
    end
  end
end
