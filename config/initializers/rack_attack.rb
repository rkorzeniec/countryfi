# frozen_string_literal: true

Rack::Attack.blocklist('block dodgy paths') do |request|
  request.path.start_with?(
    '/firma', '/nyheder', '/index.php', '/fileadmin', '/uploads',
    '/typo3temp', '/nc', '/mekanisk-sikring', '/opslagsstof'
  )
end

Rack::Attack.blocklist('block dodgy hosts') do |request|
  request.host.include?('hfb.dk') || request.referer&.include?('hfb.dk')
end
