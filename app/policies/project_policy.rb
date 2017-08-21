class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?

      scope.joins(:roles).where(roles: { user_id: user })
    end
  end

  def show?
    # two instance vars for the class
    # @user and @record
    # for example, @record could be Project
    # then Project must has_many :roles
    user.try(:admin?) || record.has_member?(user)
    # user might be nil (not logged in)
  end

  def update?
    user.try(:admin?) || record.has_manager?(user)
  end
end
