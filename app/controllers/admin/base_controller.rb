class Admin::BaseController < ApplicationController
  before_filter() { |c| c.require_permission :editor}

  def index
    @editors = User.where("role = #{EDITOR_ROLE}")
  end
end
