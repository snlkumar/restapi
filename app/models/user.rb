class User < ActiveRecord::Base
  validates :name,:city,presence: true
  has_one :apikey, dependent: :destroy
  after_create :create_api_key
  
  private
    def create_api_key
      Apikey.create :user => self
    end
    
end
