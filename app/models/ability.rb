class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :manage, Food, user_id: user.id
  end
end
