# frozen_string_literal: true

require 'tty-prompt'
require 'byebug'

class RailsInit
  def self.run
    command = ['rails']

    prompt = TTY::Prompt.new

    version = prompt.ask('What version do you need?', default: '6.0.3')
    # install required version
    # Gem::Dependency.new('rails')
    # Gem.install gem_name, gdep.requirement
    # rails _4.2.7.1_ new appname
    command << "_#{version}_"
    command << 'new'

    name = prompt.ask('What is the name of the app?', default: 'MyApp')
    command << name

    database_options = %w[mysql postgresql sqlite3 oracle frontbase ibm_db sqlserver jdbcmysql jdbcsqlite3 jdbcpostgresql jdbc]
    database = prompt.enum_select('Which database do you need?', database_options, default: 2)
    command << "--database=#{database}"

    skip_features = []

    version_control_options = %w[gemfile git keep]
    version_control_choices = prompt.multi_select('Version control', version_control_options, default: [1, 2, 3])
    skip_features += (version_control_options - version_control_choices)

    rails_features = %w[action-mailer action-mailbox action-text active-record active-storage action-cable]
    rails_choices = prompt.multi_select('Features', rails_features, default: [1, 2, 3, 4, 5, 6])
    skip_features += (rails_features - rails_choices)

    server_features = %w[puma spring listen bootsnap]
    server_options = prompt.multi_select('Server', server_features, default: [1, 4])
    skip_features += (server_features - server_options)

    js_features = %w[sprockets javascript turbolinks webpacker]
    js_choices = prompt.multi_select('Assets', js_features, default: [4])
    skip_features += (js_features - js_choices - ['webpacker'])

    if js_choices.include?('webpacker')
      js_frameworks = %w[none react vue angular elm stimulus]
      framework = prompt.enum_select('Webpack', js_frameworks, default: 1)
      if framework == 'none'
        command << '--webpacker'
      else
        command << "--webpack=#{framework}"
      end
    end

    test_options = %w[test system-test]
    test_choices = prompt.multi_select('Tests', test_options, default: [])
    skip_features += (test_options - test_choices)

    skip_features.each do |feature|
      command << "--skip-#{feature}"
    end

    system(*command)
  end
end
