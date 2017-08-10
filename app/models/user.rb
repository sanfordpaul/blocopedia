class User < ApplicationRecord
  # Include default devise modules. Others available are :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable


  after_initialize { self.role ||= :standard }


  enum role: [:standard, :premium, :admin]


  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
end
