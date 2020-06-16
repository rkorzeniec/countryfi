# frozen_string_literal: true

module ApplicationHelper
  def page_title
    @page_title.presence || 'Countrify'
  end

  def render_date(date)
    return unless date

    date.strftime('%Y-%m-%d')
  end

  def nav_item_id(path)
    path.split('/').join('-')[1..]
  end

  def gravatar_url(size)
    gravatar_user = current_user&.email || ''
    gravatar_id = Digest::MD5.hexdigest(gravatar_user).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mp"
  end

  def flash_message_type(message_type)
    case message_type
    when 'error' then 'danger'
    when 'notice' then 'info'
    else message_type
    end
  end
end
