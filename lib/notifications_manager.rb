class NotificationsManager

  def self.notify(whom, subject, body, by)
    if by.nil? || by != whom
      whom.notify(subject, body)
    end
  end
end