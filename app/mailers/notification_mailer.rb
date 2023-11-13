class NotificationMailer < ApplicationMailer
    default from: 'Pankaj.Tete@cylsys.com'
    # default from: "mailgun@https://app.mailgun.com/app/sending/domains/sandboxa35ea7c10b9440d9960d8fb0edab8ca9.mailgun.org"
    def alert_admin(otp)
    @otp=otp
     mail(to: params[:email],subject: "ALERT From ADMIN")
    end    
    
end
