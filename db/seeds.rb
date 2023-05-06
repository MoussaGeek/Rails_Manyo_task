require 'date'
require 'factory_bot_rails'

admin = FactoryBot.create(:admin_user_with_tasks)
user = FactoryBot.create(:user_with_tasks)