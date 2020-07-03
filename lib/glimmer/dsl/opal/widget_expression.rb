require 'glimmer/dsl/expression'
require 'glimmer/dsl/parent_expression'
require 'glimmer/swt/widget_proxy'

module Glimmer
  module DSL
    module Opal
      class WidgetExpression < Expression
        include ParentExpression
        EXCLUDED_KEYWORDS = %w[shell display]
  
        def can_interpret?(parent, keyword, *args, &block)
          !EXCLUDED_KEYWORDS.include?(keyword) and
            parent.is_a?(Glimmer::SWT::WidgetProxy) 
        end

        def interpret(parent, keyword, *args, &block)
          Glimmer::SWT::WidgetProxy.for(keyword, parent, args)
        end
      end
    end
  end
end
