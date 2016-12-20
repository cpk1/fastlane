HighLine.track_eof = false

require 'fastlane/version'
require 'spaceship/playground'
require 'spaceship/spaceauth_runner'

module Spaceship
  class CommandsGenerator
    include Commander::Methods

    def self.start
      self.new.run
    end

    def run
      program :name, 'spaceship'
      program :version, Fastlane::VERSION
      program :description, Spaceship::DESCRIPTION
      program :help, 'Author', 'Felix Krause <spaceship@krausefx.com>'
      program :help, 'Website', 'https://fastlane.tools'
      program :help, 'GitHub', 'https://github.com/fastlane/fastlane/tree/master/spaceship'
      program :help_formatter, :compact

      global_option('-u', '--user USERNAME', 'Specify the Apple ID you want to log in with')

      command :playground do |c|
        c.syntax = 'spaceship playground'
        c.description = 'Run an interactive shell that connects you to Apple web services'

        c.action do |args, options|
          Spaceship::Playground.new(username: options.user).run
        end
      end

      command :spaceauth do |c|
        c.syntax = 'spaceship spaceauth'
        c.description = 'Authentication helper for spaceship/fastlane to work with Apple 2-Step/2FA'

        c.action do |args, options|
          Spaceship::SpaceauthRunner.new(username: options.user).run
        end
      end

      default_command :playground

      run!
    end
  end
end