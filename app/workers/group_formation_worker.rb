class GroupFormationWorker < MainWorker

  def perform
    admin = User.find_by_email_and_is_admin('admin@example.com', true)
    group_ids = Group.where(gathering_date: Date.current + 1).pluck(:id)
    group_ids.each do |group_id|
      user_count = UserGroup.where('group_id = ? and response = ?', group_id, true).size
      group = Group.find(group_id)
      if user_count >= GROUP_SIZE - 1
        group.update_attribute('status', 'formed')
        GroupWorker.perform_async('send_group_invite', {user: admin.as_json, group: group.as_json, status: 'formed'})
      else
        group.update_attribute('status', 'declined')
        GroupWorker.perform_async('send_group_invite', {user: admin.as_json, group: group.as_json, status: 'declined'})
      end 
    end if group_ids.present?
  end
end
