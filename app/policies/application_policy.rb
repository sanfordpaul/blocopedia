class ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)

    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
    if @record.private?
      user.id == record.user_id or user.admin?
    else
      true
    end
  end

  def create?
    check_logged_in
    user.present?
  end

  def new?
    check_logged_in
    user.present?
  end

  def update?
    check_logged_in
    user.id == record.user_id or user.admin?
  end

  def edit?
    check_logged_in
    user.id == record.user_id or user.admin?
  end

  def destroy?
    check_logged_in
    user.id == record.user_id or user.admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  def check_logged_in
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
  end
end
