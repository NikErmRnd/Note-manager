class User < ApplicationRecord

    has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }
                      { validate_media_type: false }
                                 #:path => ":rails_root/files/:basename.:extension",
    do_not_validate_attachment_file_type :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable
  #enum role: { member: 1, admin: 2 }

  before_create :assign_default_role

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end


    ROLES = %i[admin user]

    def roles=(roles)
      roles = [*roles].map { |r| r.to_sym }
      self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
    end

    def roles
      ROLES.reject do |r|
        ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
      end
    end

    def has_role?(role)
      roles.include?(role)
    end


    private

    def assign_default_role
      self.roles = "user"
    end


end
