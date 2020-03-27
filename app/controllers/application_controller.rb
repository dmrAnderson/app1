class ApplicationController < ActionController::Base

	add_flash_types :success, :danger, :info, :warning
	include SessionsHelper

	def redirect_current_user
		redirect_to :root if current_user
	end
end
