# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_alert(obj)
    if obj == "notice"
      alert = "info"
    elsif obj == "success"
      alert == "success"
    elsif obj == "alert"
      alert = "danger"
    end
    alert
  end
end
