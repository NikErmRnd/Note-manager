class User < ApplicationRecord
    has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }
                      { validate_media_type: false }

                                 #:path => ":rails_root/files/:basename.:extension",
    do_not_validate_attachment_file_type :avatar
   # validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
   # validates_attachment_content_type :avatar, :content_type => [/\Aimage/, 'application/octet-stream']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  #enum role: { member: 1, admin: 2 }

  before_create :assign_default_role

    def self.find_for_facebook_oauth access_token
      user = User.where(:url => access_token.info.urls.Facebook).first
      if user.persisted?
        user
      else
        User.create!(:provider => access_token.provider,
                     :url => access_token.info.urls.Facebook,
                     :username => access_token.extra.raw_info.name,
                     :nickname => access_token.extra.raw_info.username,
                     :email => access_token.extra.raw_info.email,
                     :password => Devise.friendly_token[0,20])
      end
    end


    def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else
      User.create!(:provider => access_token.provider,
                   :url => access_token.info.urls.Vkontakte,
                   :username => access_token.info.name,
                   :nickname => access_token.extra.raw_info.domain,
                   :email => access_token.extra.raw_info.domain+'@vk.com',
                   :password => Devise.friendly_token[0,20])

    end
    end

    private

    def assign_default_role
      self.role = "user"
    end


end
