require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true, url: true
  validates :title, presence: true

  private

  def set_default_status
    self.status = false
  end
end
