module ApplicationHelper
  FLASH_TYPES = {
    alert: 'warning',
    notice: 'info'
  }.freeze

  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}"
  end

  def flash_messages
    safe_join(flash.map { |type, message| content_tag :p, message.html_safe, class: flash_type(type), role: 'alert' })
  end

  def flash_type(type)
    "alert alert-#{FLASH_TYPES[type.to_sym]}"
  end
end
