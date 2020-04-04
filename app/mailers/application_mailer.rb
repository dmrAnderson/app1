# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'vanystanok@ukr.net'
  layout 'mailer'
end
