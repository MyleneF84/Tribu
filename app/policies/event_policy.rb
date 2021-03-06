class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
    #user.event == nil
  end

  def create?
    true
  end

  def accept?
    true
  end

  def decline?
    true
  end
  
  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
