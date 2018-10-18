module Paginateable
  extend ActiveSupport::Concern

  module ClassMethods

    def paginated(current_page, per_page)
      limit(per_page).offset((current_page - 1) * per_page)
    end

  end
end