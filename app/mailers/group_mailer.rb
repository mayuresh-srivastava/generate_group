class GroupMailer < ApplicationMailer
  def send_group_status(user, group, status)
    email = user['email']
    @group_id = group['id']
    @group_name = group['name']
    @gathering_date = group['gathering_date']
    @admin = User.find_by_email_and_is_admin('admin@example.com', true)

    if status == 'initiated'
      subject = t('group_initiated_subject', group_name: @group_name, gathering_date: @gathering_date)
      template = 'group_initiated'
    elsif status == 'formed'
      subject = t('group_formed_subject', group_name: @group_name, gathering_date: @gathering_date)
      template = 'group_formed'
    else
      subject = t('group_declined_subject', group_name: @group_name, gathering_date: @gathering_date)
      template = 'group_declined'
    end

    mail(to: email, subject: subject, template_name: template)
  end
end
