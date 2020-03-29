class StaticPagesController < ApplicationController

	def home
		if current_user
			@post = current_user.posts.build
			@my_posts = current_user.send_posts.paginate(page: params[:page], per_page: 8)
		end
	end

  def contact; end
end
