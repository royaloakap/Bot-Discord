# frozen_string_literal: true

# Copyright Royaloakap

module royaloakap
  module Helper
    def self.role_hierarchy(member)
      return 999 if member.owner?
      return 0 if member.roles.empty?

      member.roles.max_by(&:position).position
    end

    def self.allowed_to_mod(invoker, target)
      role_hierarchy(invoker) > role_hierarchy(target)
    end
  end
end
