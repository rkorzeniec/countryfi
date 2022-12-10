# frozen_string_literal: true

module ApplicationHelper
  def page_title
    @page_title.presence || 'Countrify'
  end

  def render_date(date)
    return unless date

    date.strftime('%Y-%m-%d')
  end

  def nav_item_id(path, scope: nil)
    item_id = path.delete_prefix('/')
    scope ? "#{item_id}-#{scope}" : item_id
  end

  def gravatar_url(size)
    gravatar_user = current_user&.email || ''
    gravatar_id = Digest::MD5.hexdigest(gravatar_user).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mp"
  end

  def user_preferences_colour
    current_user&.color || '#D70206'
  end

  def flash_message_css_class(message_type)
    case message_type
    when 'success' then 'alert-success'
    when 'error', 'alert' then 'alert-danger'
    when 'notice' then 'alert-info'
    else "alert-#{message_type}"
    end
  end

  def user_has_unread_notifications?
    Current.user.unread_notifications.exists?
  end
end
