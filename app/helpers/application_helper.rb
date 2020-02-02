module ApplicationHelper
  def page_title
    @page_title.presence || 'Countrify'
  end

  def render_date(date)
    return unless date
    date.strftime('%Y-%m-%d')
  end

  def nav_item_id(path)
    path.split('/').join('-')[1..-1]
  end

  def gravatar_url(size)
    gravatar_user = current_user&.email || ''
    gravatar_id = Digest::MD5.hexdigest(gravatar_user).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mp"
  end
end
