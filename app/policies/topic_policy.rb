class TopicPolicy < ApplicationPolicy
  def update?
    record.user == user || record.moderated_by?(user) || user.admin?
  end

  def destroy?
    update?
  end

  def close?
    update?
  end
end
