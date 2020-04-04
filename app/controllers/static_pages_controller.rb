# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if current_user
      @post = current_user.posts.build
      @posts = current_user.posts_for_user.paginate(page: params[:page],
                                                    per_page: 9)
    end
  end

  def contact; end
end
