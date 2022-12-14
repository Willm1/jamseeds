class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def chatroom
    record.user == user
  end

  def update?
    record == user
  end

  def profile?
    true
  end
end
