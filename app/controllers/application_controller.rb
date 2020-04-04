class ApplicationController < ActionController::Base

	add_flash_types :success, :danger, :info, :warning
	include SessionsHelper

	private

		def logged_in_user
			redirect_to :signup, danger: "Please log in." unless current_user
		end

		def redirect_current_user
			redirect_to :root if current_user
		end
end
