module ApplicationHelper
  def current_user_has_permission?(permission)
    if current_user.present? && current_user.has_permission?(permission)
      true
    else
      false
    end
  end

  def get_styles(type = nil)
    #Rails.cache.fetch('beverage_categories', expires_in: 1.hours) {
      records = YAML::load(File.open("db/seeds/styles.yml"))
    #}
    records = records[type.downcase] if type.present?
    records
  end

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

    # example: <%= link_to_add_fields( t("recipes.add"), f, :ingredients, ".steps" ) %>
  # name:  the words displayed on the add field link
  # max_len: the max num for the added item
  # divname: the position inside which to insert the item
  def link_to_add_fields(name, f, association, selector)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name,  "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\", \"#{selector}\")")
  end

  def link_to_remove_fields(name, f, html_options)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", html_options)
  end

end
