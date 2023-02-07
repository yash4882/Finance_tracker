class EmailJob < ApplicationJob
	queue_as :default

	def perform(employee)
		@employee = employee
		WelcomeMailer.welcome_email.deliver_now
	end
end