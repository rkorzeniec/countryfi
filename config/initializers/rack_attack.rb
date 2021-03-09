# frozen_string_literal: true

Rack::Attack.blocklist('block dodgy paths') do |request|
  request.path.start_with?(
    '/firma/', '/nyheder/', '/index.php', '/fileadmin/', '/fileadmin/', '/uploads/',
    '/typo3temp/', '/nc/', '/mekanisk-sikring', '/opslagsstof/'
  )
end

Rack::Attack.blocklist('block dodgy referrers') do |request|
  request.referer&.include?('hfb.dk')
end
