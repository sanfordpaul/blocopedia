class Wiki < ApplicationRecord
  has_many :collaborations
  has_many :users, through: :collaborations


  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user_id, presence: true
  validates :private, inclusion: { in: [true, false] }

  scope :all_access, -> { where(private: false) }
  scope :limited_access, -> { where(private: true) }
  scope :created_by, -> (user_id) {where(user_id: user_id)}


  after_initialize { self.private ||= false}

  attr_accessor :user
  attr_accessor :collaborations
end
