class RelationshipsController < ApplicationController
	before_action :logged_in_user

	def create
		user = User.find(params[:id])
		current_user.follow(user)
		redirect_to user
	end

	def destroy
		user = Relationship.find(params[:id])
		current_user.unfollow(user)
		redirect_to user
	end

	private

		def relationship_params
			params.require(:relationships).permit(:fo)
		end
end
