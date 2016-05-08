require 'bundler/setup'
require 'minitest/autorun'
require 'mail_guard'

ENV["RAILS_ENV"] = "test"
ENV['DATABASE_URL'] = 'sqlite3://localhost/:memory:'

require "rails"

if Rails.version == '3.2.14'
  require 'test/unit'
  require "apps/rails3_2"
elsif Rails.version >= '4.0.0'
  require "apps/rails4"
end

if Rails.version >= '4.2'
  DELIVER_METHOD = :deliver_now
else
  DELIVER_METHOD = :deliver
end
