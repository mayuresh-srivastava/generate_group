class ApplicationMailer < ActionMailer::Base
  default from: FROM_DOMAIN
  layout 'mailer'
end
