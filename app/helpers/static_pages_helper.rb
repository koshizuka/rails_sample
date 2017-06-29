module StaticPagesHelper
  def status_action(feed_item)
    if feed_item.not_started?
      "はじめる"
    elsif feed_item.working?
      "おわらせる"
    else
      "おわってる"
    end
  end
end
