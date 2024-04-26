class PrefixEmailSubject
  def self.delivering_email(mail)
    mail.subject = "[Berheim] " + mail.subject
  end
end
ActionMailer::Base.register_interceptor(PrefixEmailSubject)