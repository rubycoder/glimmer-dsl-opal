require 'glimmer/dsl/static_expression'
require 'glimmer/dsl/parent_expression'
require 'glimmer/opal/layout_data_proxy'

module Glimmer
  module DSL
    module Opal
      class LayoutDataExpression < StaticExpression
        include ParentExpression

        def interpret(parent, keyword, *args, &block)
          Glimmer::Opal::LayoutDataProxy.new(parent, args)
        end
      end
    end
  end
end
