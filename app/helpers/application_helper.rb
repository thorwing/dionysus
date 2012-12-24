module ApplicationHelper
  def is_mobile_client
    (/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/.match request.env['HTTP_USER_AGENT'].downcase).present?
  end

  def users_browser
    user_agent =  request.env['HTTP_USER_AGENT'].downcase
    @users_browser ||= begin
    if user_agent.index('msie') && !user_agent.index('opera') && !user_agent.index('webtv')
                  'ie'+user_agent[user_agent.index('msie')+5].chr
      elsif user_agent.index('gecko/')
          'gecko'
      elsif user_agent.index('opera')
          'opera'
      elsif user_agent.index('konqueror')
          'konqueror'
      elsif user_agent.index('ipod')
          'ipod'
      elsif user_agent.index('ipad')
          'ipad'
      elsif user_agent.index('iphone')
          'iphone'
      elsif user_agent.index('chrome/')
          'chrome'
      elsif user_agent.index('applewebkit/')
          'safari'
      elsif user_agent.index('googlebot/')
          'googlebot'
      elsif user_agent.index('msnbot')
          'msnbot'
      elsif user_agent.index('yahoo! slurp')
          'yahoobot'
      #Everything thinks it's mozilla, so this goes last
      elsif user_agent.index('mozilla/')
          'gecko'
      else
          'unknown'
      end
    end

    return @users_browser
  end

  def truncate_text(text, length)
    text ||= ""
    text = strip_tags(text)
    if text.size > length
      #3 for dots
      text[0..length - 2] + "..."
    else
      text
    end
  end
end
