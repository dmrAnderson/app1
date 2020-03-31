class StaticPagesController < ApplicationController

	def home
		if current_user
			@post = current_user.posts.build
			@posts = current_user.get_posts.paginate(page: params[:page], per_page: 9)
		end
	end

  def contact; end
end
