class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all
  has_many :roles, dependent: :delete_all

  def has_member?(user)
    roles.exists?(user_id: user)
  end

  [:viewer, :editor, :manager].each do |role|
    define_method "has_#{role}?" do |user|
      roles.exists?(user_id: user, role: role)
    end
  end
end
