class Cooler
  def self.crazy_register?(ip)
    users = User.where(:remote_ip => ip, :created_at.gt => REGISTRATION_COOLDOWM_INTERVAL.hours.ago).to_a
    users.size >= REGISTRATION_COOLDOWM_LIMIT
  end

  def self.rapid_commenter?(user)
    comments = user.comments.where("created_at > ?", COMMENTS_COOLDOWM_INTERVAL.seconds.ago)
    comments.size >= COMMENTS_COOLDOWM_LIMIT
  end
end