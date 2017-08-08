class User < ApplicationRecord
  # Include default devise modules. Others available are :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  before_save { self.role ||= :member }
  before_save { self.account ||= :standard }

  enum role: [:member, :admin]
  enum account: [:standard, :premium]

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :email,
          presence: true,
          uniqueness: { case_sensitive: false },
          length: { minimum: 3, maximum: 254 }
end
