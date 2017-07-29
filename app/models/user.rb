class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  ROLES = %i[admin user].freeze

  def self.from_omniauth(auth)
    where(omniauth_provider: auth.provider, omniauth_uid: auth.uid).first_or_create do |user|
      user.omniauth_provider = auth.provider
      user.omniauth_uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.image_url = auth.info.image
    end
  end
end
