class NotificationMailer < ApplicationMailer

    def alert_admin
     mail(to: "rails@gmail.com",subject: "ALERT From ADMIN")
    end    
end
