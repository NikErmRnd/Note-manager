class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      # can :create, Note
      # can :update, Note
      # can :read, :all
      cannot :import, Book
      can :update, :Note
      can :read, :all
    else
      can :read, :all
    end
  end
end
