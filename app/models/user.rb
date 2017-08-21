class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # scope define a method which called on User, returns a subset of users table
  scope :excluding_archived, lambda { where(archived_at: nil) }
  has_many :roles

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def archive
    self.update(archived_at: Time.now)
  end

  def active_for_authentication?
    super && archived_at.nil?
  end

  def inactive_message
    # symbol :archived is a translation key
    archived_at.nil? ? super : :archived
  end

  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end
end
