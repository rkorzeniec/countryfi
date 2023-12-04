# frozen_string_literal: true

module ApplicationHelper
  def page_title
    @page_title.presence || 'Countrify'
  end

  def render_date(date)
    return unless date

    date.strftime('%Y-%m-%d')
  end

  def active_nav_class(name)
    return unless current_controller?(name)

    '!text-white'
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

  def flash_message_css(message_type)
    case message_type
    when 'success' then 'text-green-800 bg-green-50'
    when 'error', 'alert' then 'text-red-800 bg-red-50'
    when 'notice' then 'text-blue-800 bg-blue-50'
    else 'bg-gray-50'
    end
  end

  def flash_message_close_button_css(message_type)
    case message_type
    when 'success' then 'bg-green-50 text-green-500 focus:ring-green-400 hover:bg-green-200'
    when 'error', 'alert' then 'bg-red-50 text-red-500 focus:ring-red-400 hover:bg-red-200'
    when 'notice' then 'bg-blue-50 text-blue-500 focus:ring-blue-400 hover:bg-blue-200'
    else 'bg-gray-50 text-gray-500 focus:ring-gray-400 hover:bg-gray-200'
    end
  end

  def flash_message_sr_text(message_type)
    case message_type
    when 'success' then 'Success'
    when 'error', 'alert' then 'Error'
    when 'notice' then 'Info'
    else 'Notice'
    end
  end

  def user_has_unread_notifications?
    Current.user.unread_notifications.exists?
  end
end
