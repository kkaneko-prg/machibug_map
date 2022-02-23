class ContactMailer < ApplicationMailer
  def send_contact_mail(contact)
    @contact = contact
    mail(to: ENV['TOMAIL'],
         subject: '【街バグmap】お問い合わせがありました')
  end
end
