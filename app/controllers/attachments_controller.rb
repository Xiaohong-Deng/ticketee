class AttachmentsController < ApplicationController
  skip_after_action :verify_authorized, only: [:new]

  def show
    attachment = Attachment.find(params[:id])
    authorize attachment, :show?
    send_file file_to_send(attachment), disposition: :inline
    # recall we mount_uploader AttachmentUploader to :attachment.file
    # so attachment.file though is a string, is converted to an object
    # by CarrierWave and method path can be called on it to generate
    # a url, disposition: :inline tell send_file to display file content
    # in the browser
  end

  def new
    @index = params[:index].to_i
    @ticket = Ticket.new
    @ticket.attachments.build
    render layout: false
  end

  private
    def file_to_send(attachment)
      if URI.parse(attachment.file.url).scheme
        filename = "/tmp/#{attachment.attributes["file"]}"
        File.open(filename, "wb+") do |tf|
          td.write open(attachment.file.url).read
        end
        filename
      else
        attachment.file.path
      end
    end
end
