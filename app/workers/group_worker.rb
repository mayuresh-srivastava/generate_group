class GroupWorker < MainWorker
  sidekiq_options queue: 'mailers'

  def perform(action, args)
    send(action, args)
  end

  private

  def send_group_status_mail(data)
    GroupMailer.send_group_status(data['user'], data['batch'], data['status']).deliver
  end
end
