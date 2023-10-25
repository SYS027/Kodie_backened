class ApplicationMailer < ActionMailer::Base
  default from: "mailgun@https://app.mailgun.com/app/sending/domains/sandboxa35ea7c10b9440d9960d8fb0edab8ca9.mailgun.org"
  layout "mailer"
end
