class Users::SessionsController < Devise::SessionsController
  layout 'home'

  #
  # for user login with student code verify or delete
  #
  # def new
  #   super
  # end

  #
  # for student login with create cookie
  #
  # def create
  #   super
  # end
end
