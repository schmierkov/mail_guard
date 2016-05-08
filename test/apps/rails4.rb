# test/apps/rails4.rb
require "rails"
require 'rails/all'
require 'action_view/testing/resolvers'
require 'rails/test_help'

require 'mail_guard' # our gem

module Rails4
  class Application < Rails::Application
    config.root = File.expand_path("../../..", __FILE__)
    config.cache_classes = true
    config.eager_load = false
    config.serve_static_files = true
    config.static_cache_control = "public, max-age=3600"
    config.consider_all_requests_local = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection = false
    config.active_support.deprecation = :stderr
    config.action_mailer.delivery_method = :test
    config.middleware.delete "Rack::Lock"
    config.middleware.delete "ActionDispatch::Flash"
    config.middleware.delete "ActionDispatch::BestStandardsSupport"
    config.secret_key_base = '49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk'
    config.active_support.test_order = :random
  end
end

class WelcomeMailer < ActionMailer::Base
  default from: "noreply@foobar.com"
  self.view_paths = [ActionView::FixtureResolver.new(
    "welcome_mailer/hello.html.erb"=> 'Hello from index.html.erb',
  )]

  def hello(to:, subject: "Default Subject")
    mail(to: to, subject: subject)
  end
end

Rails4::Application.initialize!
