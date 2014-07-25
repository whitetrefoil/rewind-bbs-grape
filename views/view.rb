
module RewindBBS
  module View
    module ListRepresenter
      def self.included(base)
        base.property :count, as: :total
        base.property :pre_page
        base.property :total_pages
        base.property :current_page
        base.property :from
        base.property :to
      end
    end
  end
end

require_relative 'user'
