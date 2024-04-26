Rack::Attack.cache.store = Redis.new(path: "/home/berheim/.redis/sock") if Rails.env.production?

# Block attacks from IPs in cache
# To add an IP: Rails.cache.write("block 1.2.3.4", true, expires_in: 2.days)
# To remove an IP: Rails.cache.delete("block 1.2.3.4")
Rack::Attack.blocklist("block IP") do |req|
  ip = req.env["action_dispatch.remote_ip"]
  Rack::Attack.cache.read("block #{ip}")
end
