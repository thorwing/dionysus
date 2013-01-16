module Translatable
  def self.included(base)
    base.class_eval do
      include InstanceMethods
    end
  end

  module InstanceMethods
    def full_name
      full_name = name || ''
      full_name += " / " if name.present? && trans_name.present?
      full_name += trans_name if trans_name.present?
      full_name
    end
  end
end
