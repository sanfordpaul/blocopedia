class CollaborationPolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    check_logged_in
     @user.admin? || ! @user.standard?


  end

  def update?
     check_logged_in
     @user.admin? || ! @user.standard?


  end



end
