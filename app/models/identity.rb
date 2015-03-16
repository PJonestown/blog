class Identity < ActiveRecord::Base
  belongs_to :commenter
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oath(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end
