class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Subscriber
end
