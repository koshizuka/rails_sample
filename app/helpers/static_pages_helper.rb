module StaticPagesHelper
  def status_action(feed_item)
    if feed_item.not_started?
      "開始"
    elsif feed_item.working?
      "完了"
    else
      "保留"
    end
  end
end
