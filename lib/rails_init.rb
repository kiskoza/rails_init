# frozen_string_literal: true

require 'tty-prompt'
require 'byebug'

class RailsInit
  def self.run
    command = ['rails']

    prompt = TTY::Prompt.new

    # version = prompt.ask('What version do you need?', default: '6.0.3')
    # # install required version
    # # Gem::Dependency.new('rails')
    # # Gem.install gem_name, gdep.requirement
    # # rails _4.2.7.1_ new appname
    # command << "_#{version}_"

    command << 'new'

    name = prompt.ask('What is the name of the app?', default: 'MyApp')
    command << name

    database_options = %w[mysql postgresql sqlite3 oracle frontbase ibm_db sqlserver jdbcmysql jdbcsqlite3 jdbcpostgresql jdbc]
    database = prompt.enum_select('Which database do you need?', database_options, default: 2)
    command << "--database=#{database}"

    skip_features = []

    version_control_options = %w[gemfile git keep]
    version_control_choices = prompt.multi_select('Select your starter pack!', version_control_options, default: [1, 2, 3])
    skip_features += (version_control_options - version_control_choices)

    rails_features = %w[action-mailer action-mailbox action-text active-record active-storage action-cable]
    rails_choices = prompt.multi_select('Choose your favourite features!', rails_features, default: [1, 2, 3, 4, 5, 6])
    skip_features += (rails_features - rails_choices)

    server_features = %w[puma spring listen bootsnap]
    server_options = prompt.multi_select('Customize your server!', server_features, default: [1, 4])
    skip_features += (server_features - server_options)

    js_features = %w[sprockets turbolinks webpacker]
    js_choices = prompt.multi_select('How do you want to handle your frontend?', js_features, default: [3])
    skip_features += (js_features - js_choices - ['webpacker'])

    if js_choices.include?('webpacker')
      command << '--webpacker'

      js_frameworks = %w[none react vue angular elm stimulus]
      framework = prompt.enum_select('Maybe you need a framework for it?', js_frameworks, default: 1)
      unless framework == 'none'
        command << "--webpack=#{framework}"
      end
    end

    if js_choices.empty?
      skip_javascript = prompt.yes?('Do you want to skip javascript entirely?')
      skip_features << 'javascript' if skip_javascript
    end

    test_options = %w[test system-test]
    test_choices = prompt.multi_select('Testing is important too', test_options, default: [])
    skip_features += (test_options - test_choices)

    skip_features.each do |feature|
      command << "--skip-#{feature}"
    end

    puts *command
    system(*command)
  rescue TTY::Reader::InputInterrupt => e
    prompt.say('Goodbye :(')
  end
end
