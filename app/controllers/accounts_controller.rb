class AccountsController < ApplicationController
  before_action :authenticate_recruiter!

  def show
  end
end
