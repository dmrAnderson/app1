class PostsController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user, only: [:destroy]

	def create
		@post = current_user.posts.build(post_params)
		@posts = current_user.get_posts.limit(9)
		if @post.save
			redirect_to :root, success: "Post created."
		else
			render "static_pages/home" # FIX if you reload a render page - app will be crush
		end
	end

	def destroy
		@post.destroy
		redirect_to (request.referrer || :root), success: "Post deleted."
	end

	private

		def correct_user
			@post = current_user.posts.find(params[:id])
			redirect_to :root if @post.nil?
		end

		def post_params
			params.require(:post).permit(:content, :picture)
		end
end