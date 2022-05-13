class User < ApplicationRecord
  extend FriendlyId
      friendly_id :uniqueslug, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #      :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
        :validatable, password_length: 10..70

  has_many :posts
  has_many :comments


  #enum role: [:user, :admin, :vip] # You can call your roles whatever you want. User will be 1, Admin will be 2, and VIP will be 3.
  #after_initialize :set_default_role, :if => :new_record?

  validate :password_complexity
  validates :first_name, presence: true,
  length: { minimum: 2, maximum: 25 }

  validates :last_name, presence: true,
  length: { minimum: 2, maximum: 25 }

  def uniqueslug 
    "#{first_name} #{last_name}" 
  end 

  def password_complexity
    if password.present? and not password.match(/\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  #def set_default_role
    #self.role ||= :user
  #end

end
