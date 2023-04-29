class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, length: { minimum: 6 }
    attribute :admin, :boolean, default: false

    before_update :check_admin_exist_for_update
    before_destroy :check_admin_exist_for_destroy

    private
    def check_admin_exist_for_update
        admins = User.all.where(admin: true)
        #入力されたadminがfalse(adimin権限をなくそうとしている) , 変更されようとしてるuserが今のadminの場合(つまり最後の1人)
        if admins.count == 1 && self.admin == false && self == User.find_by(admin: true)
        errors.add(:base, "L'administrateur est parti ! !")
        throw(:abort)
        end 
    end
    def check_admin_exist_for_destroy
        admins = User.all.where(admin: true)
        throw(:abort) if admins.count == 1 && self == User.find_by(admin: true)
        
    end
end
