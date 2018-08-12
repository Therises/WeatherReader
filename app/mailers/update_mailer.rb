class UpdateMailer < ApplicationMailer
	def update_email(email, forecast)
		@forecast = forecast
		mail(to: email, subject: 'Your Weather Update')
	end
end
