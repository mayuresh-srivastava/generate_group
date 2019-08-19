#Setup 

1. unzip generate_group.zip
2. cd generate_group
3. bundle
4. psql=# create user lenny password 'password' createdb;
5. rails db:create
6. rails db:migrate
6. rake db:seed to create a admin user,
7. rails s
8. sidekiq (to start sidekiq) - For sending mails and cron job

Note: Only admin can create group.

#To make a user admin:

1. cd generate_group
2. rails c
3. user = User.find(:id) or user = User.find_by_email(:email)
4. user.update_attribute('is_admin', true)
