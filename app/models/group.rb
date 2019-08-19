class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  validates :name, :gathering_date, presence:true

  enum status: { initiated: 'initiated', formed: 'formed', declined: 'declined' }

  after_commit :send_mail_to_users
end
