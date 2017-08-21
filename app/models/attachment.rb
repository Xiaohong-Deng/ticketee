class Attachment < ActiveRecord::Base
  belongs_to :ticket
  mount_uploader :file, AttachmentUploader
  # define a setter named file=, :file corresponds to the field in the form
  # AttachmentUploader is a custom Uploader class. You mount
  # the uploader on the field. It's a subclass of CarrierWave::Uploader
  # :file is also an attribute nested in the attachment_attribute, which is one
  # of the attribute of ticket. Those attributes get passed to build an Ticket isntance
  # and an Attachment instance through association.
end
