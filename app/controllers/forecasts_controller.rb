class ForecastsController < ApplicationController
	def index
		@forecasts = Forecast.all
	end
	def create
		cookies.permanent[:user_id] = SecureRandom.urlsafe_base64 unless cookies[:user_id]
		@forecast = Forecast.get_weather(forecast_params.merge(user_id: cookies[:user_id]))
	end
	def show
		@forecasts = Forecast.where(user_id: cookies[:user_id])
	end
  
  def get_user_location
		@location = request.location.city + ', ' + request.location.country_code
	end

	def email_update
		uid = cookies[:user_id]
    forecast = Forecast.where(user_id: uid).last
		forecast.update(email_address)
		Forecast.delay(run_at: 3.hours.from_now).mail_update(forecast)
		Forecast.delay(run_at: 6.hours.from_now).mail_update(forecast)
		redirect_back fallback_location: my_forecasts_path
	end
	
	private
	def forecast_params
		params.require(:forecast).permit(:city)		
	end
	def email_address
		params.require(:forecast).permit(:email)
	end
end
