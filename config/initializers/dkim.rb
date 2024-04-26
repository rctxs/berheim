if Rails.env.production?
  Dkim::domain      = 'berheim.smd.berlin'
  Dkim::selector    = '20240426'
  Dkim::private_key = open('/home/berheim/dkim/dkim_private.pem').read

  ActionMailer::Base.register_interceptor(Dkim::Interceptor)
end
