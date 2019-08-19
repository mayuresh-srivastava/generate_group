class GroupMailerPreview < ActionMailer::Preview
  def send_group_invite
    user = User.first
    group = Group.last
    GroupMailer.send_group_status(user, group, 'forme')
  end
end
