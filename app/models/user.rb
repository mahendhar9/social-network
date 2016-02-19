class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  attr_accessor :login

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: 'friend_id', dependent: :destroy
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  def request_friendship(user_2)
    self.friendships.create(friend: user_2)
  end

  def active_friends
    self.friendships.where(state: "active").map(&:friend) + 
    self.inverse_friendships.where(state: "active").map(&:user)
  end

  def pending_sent_requests
    self.friendships.where(state: "pending")
  end

  def pending_received_requests
    self.inverse_friendships.where(state: "pending")
  end

  def friendship_status(user)
    friendship = Friendship.where(user: [self.id, user.id], friend: [self.id, user.id])
    unless friendship.any?
      return "Not Friends"
    else 
      if friendship.first.state == "active"
        return "Friends"
      elsif friendship.first.user == self
        return "Requested"
      else 
        return "Pending"
      end
    end
  end

  def find_friendship_with(user)
    Friendship.where(user: [self.id, user.id], friend: [self.id, user.id]).first
  end
end
