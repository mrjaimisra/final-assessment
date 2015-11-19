class List < ActiveRecord::Base
  belongs_to :user
  has_many :links

  validates :title,
            presence: true

  def reassign_links
    if self.links != nil
      self.links.each do |link|
        link.update_attribute(:list_id, -1)
      end
    end
  end
end
