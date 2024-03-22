# typed: false
# frozen_string_literal: true

class ApplicationController < ActionController::Base

  private

  def require_signin
    unless signed_in_user
      session[:intended_url] = request.url
      redirect_to(new_session_url, alert: "PLEASE SIGN IN FIRST!!FHEWO:Ewh!")
    end
  end

  def signed_in_user
    @signed_in_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in_user?(user)
    signed_in_user == user
  end

  def require_admin
    unless signed_in_admin?
      redirect_to(root_url, alert: "I'm sorry Dave I'm afraid I can't do that")
    end
  end

  def signed_in_admin?
    signed_in_user&.admin?
  end

  helper_method :signed_in_user
  helper_method :signed_in_user?
  helper_method :signed_in_admin?
end
