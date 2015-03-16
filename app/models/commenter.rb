class Commenter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities

  TEMP_EMAIL_PREFIX = 'change@me'

  def self.find_for_oath(auth, signed_in_resource = nil)

    identity = Identity.find_for_oath(auth)

    commenter = signed_in_resource ? signed_in_resource : identity.commenter

    if commenter.nil?

      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)

      email = authinfo.email if email_is_verified

      commenter = Commenter.where(:email => email).first if email

      if commenter.nil?
        commenter = Commenter.new(
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        commenter.skip_confirmation!
        commenter.save
      end

    end

    if identity.commenter != commenter
      identity.commenter = commenter
      identity.save!
    end
    commenter
  end
end
