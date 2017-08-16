class CollaborationPolicy < ApplicationPolicy
  def show?
    check_logged_in
    user.id == record.user_id or user.admin?
  end

  def create?
    check_logged_in
    user.id == record.user_id or user.admin?
  end

  def new?
    check_logged_in
    user.id == record.user_id or user.admin?
  end

  def destroy?
    check_logged_in
    user.id == record.user_id or user.admin?
  end
end
