# frozen_string_literal: true

class AuthorDecorator < Draper::Decorator
  delegate_all

  def name
    first_name + ' ' + last_name
  end
end
