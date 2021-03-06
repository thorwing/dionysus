class FeedsManager

  # who do what to which, to whom
  def initialize(who, did, what)
    @user = who
    @action = did
    @target = what
  end

  def generate
    identity = {user_id: @user.id, type: "#{@action}Feed".camelize}

    data = {}
    case identity[:type]
      when "FollowFeed"
        data = {follow_id: @target.id, follow_nick: @target.nick}
      when "CreateFeed"
        data = {item_id: @target.id, item_type: @target.class.name}
    end

    identity[:data] = data

    ActivityFeed.create!(identity)
  end

end