module ApplicationHelper
  def body_attributes
    { class: [params[:action], params[:controller]].join(" ") }
  end

  def mobile_meta_content
    "initial-scale=1.0, maximum-scale=1.0, user-scalable=0, width=320"
  end

  def title
    @title || "Firebot"
  end
end
