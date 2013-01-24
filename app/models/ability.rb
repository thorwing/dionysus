class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all

      if !user.new_record?
        if user.author?
          can :create, Article
          can [:update, :destroy], Article do |item|
            item.author == user
          end
        elsif user.merchant?
          can :create, Deal
          can [:update, :destroy], Deal do |item|
            item.seller == user
          end
        end

        items = [Package, Review, List, Comment, Topic, Beverage, Recipe]
        can :create, items
        can [:update, :destroy], items do |item|
          item.author == user
        end

        can :create, Message
        can :create, Complain
        can [:up, :down], Vote
      end
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
