class User < ApplicationRecord

    has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }
                      { validate_media_type: false }
                                 #:path => ":rails_root/files/:basename.:extension",
    do_not_validate_attachment_file_type :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable
  enum role: { user: 1, admin: 2 }

  has_and_belongs_to_many :books

  before_create :assign_default_role

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end

    private

    def assign_default_role
      self.role = 1
    end


end
