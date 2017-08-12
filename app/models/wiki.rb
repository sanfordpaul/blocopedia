class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
  validates :private, inclusion: { in: [true, false] }

  scope :all_access, -> { where(private: false) }
  scope :limited_access, -> { where(private: true) }
  scope :created_by, -> (user) {where(user: user)}

  after_initialize { self.private ||= false}
end
