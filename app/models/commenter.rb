class Commenter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities
  has_many :comments, :as => :owner

  TEMP_EMAIL_PREFIX = 'change@me'

  def self.find_for_oath(auth, signed_in_resource = nil)

    identity = Identity.find_for_oath(auth)
    commenter = signed_in_resource ? signed_in_resource : identity.commenter

    if commenter.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = authinfo.email if email_is_verified
      commenter = Commenter.where(:email => email).first if email

      #create commenter if new registration
      if commenter.nil?
        commenter = Commenter.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        commenter.save
      end

    end

    if identity.commenter != commenter
      identity.commenter = commenter
      identity.save!
    end
    commenter
  end

  def to_s
    if name.blank?
      "No name provided"
    else
      name
    end
  end
end
