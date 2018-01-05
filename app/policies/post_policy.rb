class PostPolicy < ApplicationPolicy
  def update?
    record.user == user || record.board.moderated_by?(user) || user.admin?
  end

  def destroy?
    update?
  end

  def fetch?
    update?
  end
end
