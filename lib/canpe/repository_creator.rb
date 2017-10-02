module Canpe
  class RepositoryCreator
    class << self
      def init(path)

      end

      def operation(path)
        @_operation ||= RepositoryOperation.new(path)
      end
    end
  end
end
