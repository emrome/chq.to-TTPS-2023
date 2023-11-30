class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true, length: { minimum: 3, maximum: 25 } do
    validates :username, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }
    validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/ }
  end

  has_many :links

  def full_name
    "#{first_name} #{last_name}"
  end

end
