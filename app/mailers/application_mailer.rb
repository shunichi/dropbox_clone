class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@' + (ENV['DOMAIN_NAME'] || '')
  layout 'mailer'
end
