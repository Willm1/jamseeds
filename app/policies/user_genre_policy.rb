class UserGenrePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    record.user == user
  end

  def create?
    new?
  end

  def destroy?
    new?
  end
end
