mailchimp_templates
===================

Push and pull Mailchimp templates locally.

## Installation

First:

  $ echo "gem 'mailchimp_templates', git: 'git@github.com:benastan/mailchimp_templates.git'" >> Gemfile
  $ bundle
  $ echo "MAILCHIMP_KEY=[key_from_mailchimp]" > .env
  $ echo "require 'mailchimp/tasks'" >> Rakefile
  $ foreman run bundle exec rake -T
  rake mailchimp:templates:pull  # Pull existing templates from your Mailchimp account
  rake mailchimp:templates:push  # Push template changes to your Mailchimp account

Then:

  $ foreman run bundle exec rake mailchimp:templates:pull
  Writing template my_template.html.haml
  Writing template another_damn_template..html.haml
  $ echo "%h1 Hello, world" > some_new_template.html.haml
  $ foreman run bundle exec rake mailchimp:templates:push

Check at your [Templates](https://us2.admin.mailchimp.com/templates/). There should be a new template called "some new template". Bingo bango bongo.
