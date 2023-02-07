class WelcomeMailer < ApplicationMailer
	default from: "mavipayal3@gmail.com"

	def welcome_email
	    mail(to: 'admin@gmail.com', subject: 'Welcome to My Awesome Site')
	end
end
