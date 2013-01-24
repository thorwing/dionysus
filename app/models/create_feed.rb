class CreateFeed < ActivityFeed

  def item
    begin
      data["item_type"].singularize.classify.constantize.find(data["item_id"])
    rescue
      nil
    end
  end
end
