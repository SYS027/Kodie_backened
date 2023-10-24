class UserMailer < ApplicationMailer
    default from: 'pankajtete771@gmail.com' # Set your default sender email address
  
    def contact_email(contact)
      @contact = contact
      mail(to: 'recipient@example.com', subject: 'New Contact Form Submission')
    end
end