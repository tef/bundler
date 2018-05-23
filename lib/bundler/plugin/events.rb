# frozen_string_literal: true

module Bundler
  module Plugin
    module Events
      def self.define(const, event)
        const_set(const.to_sym, event) unless const_defined?(const.to_sym)
        @events ||= {}
        @events[event] = const
      end

      def self.defined_event?(event)
        @events ||= {}
        @events.key?(event)
      end

      # A hook called before each individual gem is installed
      # Includes a Bundler::ParallelInstaller::SpecInstallation.
      # No state, error, post_install_message will be present as nothing has installed yet
      define :GEM_BEFORE_INSTALL, "before-install"

      # A hook called after each individual gem is installed
      # Includes a Bundler::ParallelInstaller::SpecInstallation.
      #   If state is failed, an error will be present.
      #   If state is success, a post_install_message may be present.
      define :GEM_AFTER_INSTALL,  "after-install"

      # A hook called before any gems install
      # Includes an Array of Bundler::Dependency objects
      define :GEM_BEFORE_INSTALL_ALL, "before-install-all"

      # A hook called after any gems install
      # Includes an Array of Bundler::Dependency objects
      define :GEM_AFTER_INSTALL_ALL,  "after-install-all"
    end
  end
end
