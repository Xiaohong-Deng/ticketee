class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true # uniq means retrieve unique tags even if there are dups in db
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
    class_name: "User", uniq: true
  attr_accessor :tag_names
  # This little helper tells your model to accept attachment attributes along with ticket
  # attributes whenever you call methods like new, build, and update. It will also change
  # how fields_for performs in your form, making it reference the attachments association,
  # and calling the parameters that get generated in the form attachments_attributes rather than attachments.
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  before_create :assign_default_state
  after_create :author_watches_me

  searcher do
    label :tag, from: :tags, field: "name" # label is what you use to search in the search bar
    label :state, from: :state, field: "name"
  end

  def tag_names=(names)
    # @tag_names is still useful in invalid submission where
    # tags you input before is populated back to the form field
    # so you don't need to re-fill it
    @tag_names = names
    names.split.each do |name|
      # this line does 2 things
      # one is create tags if they are not in the db
      # the other is make the association to the ticket
      # which results in changing the tags_tickets joint table
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  private
    def assign_default_state
      self.state ||= State.default
    end

    def author_watches_me
      if author.present? && ! self.watchers.include?(author)
        self.watchers << author
      end
    end
end
