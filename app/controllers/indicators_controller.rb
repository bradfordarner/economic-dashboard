class IndicatorsController < ApplicationController
	def home
		@top_ten = Indicator.all 
	end

	def index
		@indicators = Indicator.all
	end

	def show
		
	end

	def new
		@indicator = Indicator.new
	end

	def create
		@indicator = Indicator.create(series: params[:indicator][:series], name: params[:indicator][:name])
		@update = Update.create do |u|
			u.indicator_id = @indicator.id
			fred = FREDAPI::Client.new "api_key" => "12920546d813f83502f63869e202006e"
			series = fred.series "series_id" => params[:indicator][:series]
			if series.error_code.nil?
				last_update = Time.parse(series.seriess.first.last_updated)
				frequency = series.seriess.first.frequency_short
				case frequency
				when "D"
					@next_release = last_update + 1.day
				when "Q"
					@next_release = last_update + 3.month
				when "M"
					@next_release = last_update + 1.month
				when "A"
					@next_release = last_update + 12.month
				else
					@next_release = last_update + 1.month
				end

				@observations = fred.series_observations "series_id" => params[:indicator][:series]
				u.observations = @observations
			else
				flash.now[:error] = "Unable to find Series ID that you entered"
			end
		end 
		@indicator.observations = @observations
		@indicator.next_release = @next_release
		if @indicator.save
			flash.now[:success] = "Indicator Added"
			redirect_to root_url
		else
			redirect_to root_url
		end
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		indicator = Indicator.find(params[:id])
		indicator.delete
		redirect_to :back
	end
end
