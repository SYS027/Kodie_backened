class NotificationMailer < ApplicationMailer
    default from: 'Pankaj.Tete@cylsys.com'
    def alert_admin(otp)
    @otp=otp
     mail(to: params[:email],subject: "ALERT From ADMIN")
    end    
end
