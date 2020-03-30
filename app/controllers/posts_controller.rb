class PostsController < ApplicationController
	before_action :logged_in_user

	def create
		@post = current_user.posts.build(post_params)
		@posts = current_user.send_posts.paginate(page: params[:page], per_page: 8)
		if @post.save
			redirect_to :root, success: "Post created!"
		else
			render "static_pages/home"
		end
	end

	def destroy
		
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end
end
