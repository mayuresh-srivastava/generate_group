module Subscriber
  extend ActiveSupport::Concern
  
  def send_mail_to_users
    user_ids = UserGroup.where(response: true).pluck(:user_id)
    if user_ids.present?
      users = User.where('id not in (?)', user_ids).to_a.shuffle.in_groups_of(GROUP_SIZE + 1).flatten.compact
    else
      users = User.all.to_a.shuffle.in_groups_of(GROUP_SIZE + 1).flatten.compact
    end

    users.each do |user|
      GroupWorker.perform_async('send_group_status_mail', {user: user.as_json, group: self.as_json, status: 'initiated'})
    end if users.present?
  end
end
