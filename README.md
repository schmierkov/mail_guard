# MailGuard
[![Build Status](https://travis-ci.org/schmierkov/mail_guard.svg?branch=master)](https://travis-ci.org/schmierkov/mail_guard)
[![Code Climate](https://codeclimate.com/github/schmierkov/mail_guard/badges/gpa.svg)](https://codeclimate.com/github/schmierkov/mail_guard)
[![Issue Count](https://codeclimate.com/github/schmierkov/mail_guard/badges/issue_count.svg)](https://codeclimate.com/github/schmierkov/mail_guard)
[![Test Coverage](https://codeclimate.com/github/schmierkov/mail_guard/badges/coverage.svg)](https://codeclimate.com/github/schmierkov/mail_guard/coverage)

In your Gemfile add:

    gem 'mail_guard'


Add MailGuard configurations to `config/initializers/interceptor.rb`:

    ActionMailer::Base.register_interceptor(
      MailGuard.new(permitted_hosts: ["@gmail.com"])
    )

## Recipients

    MailGuard.new(recipients: ["foo@bar.com"])
    
## Permitted Hosts

    MailGuard.new(permitted_hosts: ["@bar.com", "google.de"])
    
## Subject Prefix

    MailGuard.new(subject_prefix: "POWER_PREFIX")

With the subject parameter you have the option to set a specific prefix. The default of `subject_prefix` is false.
These are your options:

      subject_prefix: true       # with the environment your app is running e.g. [STAGING]
      subject_prefix: "MYPREFIX" # prefixes subject with string
      subject_prefix: false      # does not use subject prefix
