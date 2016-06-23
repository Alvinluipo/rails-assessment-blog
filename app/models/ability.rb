    class Ability
      include CanCan::Ability
 
      def initialize(user)
        can :read, Post
        can :create, Post, owner_id: user.id
        unless user.nil? # guest
          # CanCan accepts a hash of conditions;
          # here, we're saying that the Post's user_id
          # needs to match the requesting User's id
          can :update, Post, { user_id: user.id }
          can :create, Comment
        end
        if user.admin?
          can :manage, Post
        end
      end
    end