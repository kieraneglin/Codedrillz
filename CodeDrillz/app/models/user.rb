class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  has_many :points, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :earned_badges, through: :groups
  has_many :user_drills, dependent: :destroy
  has_many :drills, through: :user_drills

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def self.send_reset_password_instructions(attributes={})
     recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
     if !recoverable.approved?
       recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
     elsif recoverable.persisted?
       recoverable.send_reset_password_instructions
     end
     recoverable
   end
end
