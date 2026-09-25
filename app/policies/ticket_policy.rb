class TicketPolicy < ApplicationPolicy
  def show?
    user.admin? ||
      record.customer == user ||
      record.agent == user
  end

  def update?
    user.admin? ||
      record.agent == user ||
      record.customer == user
  end

  def destroy?
    user.admin? || record.customer == user
  end

  # class Scope < ApplicationPolicy::Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end
end



