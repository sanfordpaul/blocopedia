class ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)

    @user = user
    @record = record
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
