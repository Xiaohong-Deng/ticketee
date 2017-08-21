module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&block)
    # &blk is a block, blk is a Proc
    # Having a column admin:boolean automatically
    # gives admin? method to User object
    # yield works too
    block.call if current_user.try(:admin?)
  end
end
