# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_current_user, except: [:destroy]

  def new; end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        remember(user) if params[:session][:remember_me] == '1'
        log_in(user)
        redirect_to :root, success: 'Welcome back, you Log In.'
      else
        redirect_to :root, warning: 'Account not activated. Check your email.'
      end
    else
      flash.now[:danger] = 'Incorrect username or password.'
      render :new
    end
  end

  def destroy
    log_out(current_user)
    redirect_to :root, info: 'Bay-bay, it was nice to see you.'
  end
end
