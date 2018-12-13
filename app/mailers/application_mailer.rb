class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@turing.io'
  layout 'mailer'
end
