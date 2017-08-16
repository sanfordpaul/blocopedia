class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
    if @record.private?
      user.id == record.user_id or user.admin? or record.users.include?(user)
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
    user.id == record.user_id or user.admin? or record.users.include?(user)
  end

  def edit?
    check_logged_in
    user.id == record.user_id or user.admin? or record.users.include?(user)
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




#   class Scope
#       attr_reader :user, :scope
#
#       def initialize(user, scope)
#         @user = user
#         @scope = scope
#       end
#
#       def resolve
#         wikis = []
#         if user.role == 'admin'
#           wikis = scope.all # if the user is an admin, show them all the wikis
#         elsif user.role == 'premium'
#           all_wikis = scope.all
#           all_wikis.each do |wiki|
#             if wiki.public? || wiki.user_id == user.id || wiki.users.include?(user)
#               wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
#             end
#           end
#         else # this is the lowly standard user
#           all_wikis = scope.all
#           wikis = []
#           all_wikis.each do |wiki|
#             if wiki.public? || wiki.users.include?(user)
#               wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
#             end
#           end
#         end
#         wikis # return the wikis array we've built up
#       end
#     end
end
