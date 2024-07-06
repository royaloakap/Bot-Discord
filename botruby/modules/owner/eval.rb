# frozen_string_literal: true

# Copyright Royaloakap

module royaloakap
  module Owner
    royaloakap.crb.add_command(
      :raweval,
      code: proc { |event, args|
        event.respond(eval(args.join(' ')))
      },
      triggers: ['raweval '],
      owners_only: true
    )

    royaloakap.crb.add_command(
      :eval,
      code: proc { |event, args|
        begin
          msg = event.respond "#{royaloakap.config['emoji_loading']} Evaluating..."
          init_time = Time.now
          result = eval args.join(' ')
          result_output = handle_result(result, init_time)
          msg.edit(result_output)
        rescue StandardError => e
          msg.edit("#{royaloakap.config['emoji_error']} An error has occurred!" \
                   "```ruby\n#{e}```" \
                   "Command took #{Time.now - init_time} seconds to execute!")
        end
      },
      triggers: ['eval2 ', 'eval'],
      owners_only: true,
      description: 'Evaluate a Ruby command. Owner only.'
    )

    royaloakap.crb.add_command(
      :bash,
      code: proc { |event, args|
        init_time = Time.now
        msg = event.respond "#{royaloakap.config['emoji_loading']} Evaluating..."
        # Capture all output, including STDERR.
        result = `#{"#{args.join(' ')} 2>&1"} `
        result_output = handle_result(result, init_time)
        msg.edit(result_output)
      },
      triggers: ['bash ', 'sh ', 'shell ', 'run '],
      owners_only: true,
      description: 'Evaluate a Bash command. Owner only. Use with care.'
    )

    # Formulates results to an external source or character-specific message.
    # @param [Object] result_output Returned result of an operation.
    # @param [Class<Time>] start_time The starting time of execution.
    # @param [Class<Time>] finish_time The ending time of execution.
    # @return [String (frozen)] Human-readable format of given execution
    def self.handle_result(result_output, start_time, finish_time = Time.now)
      output = ''

      result = result_output.to_s
      if result.nil? || result == '' || result == ' ' || result == "\n"
        output += '' "#{royaloakap.config['emoji_tickbox']} Done! (No output)\n"
      elsif result.length >= 1984
        uploader_domain = royaloakap.config['hastebin_instance_url']
        uploader_file = royaloakap.uploader.upload_raw(result)

        output += "#{royaloakap.config['emoji_warning']}" \
                  'Your output exceeded the character limit! ' \
                  "(`#{result.length}`/`1984`)\n" \
                  "You can view the result here: #{uploader_domain}/raw/#{uploader_file}\n"
      else
        output += "Output: ```\n#{result}```"
      end

      output += "Command took #{finish_time - start_time} seconds to execute!"
      output
    end
  end
end
