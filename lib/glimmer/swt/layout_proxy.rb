require 'glimmer/swt/property_owner'

module Glimmer
  module SWT
    class LayoutProxy
      include Glimmer::SWT::PropertyOwner
      
      class << self
        # Factory Method that translates a Glimmer DSL keyword into a WidgetProxy object
        def for(keyword, parent, args)
          the_layout_class = layout_class(keyword) || Glimmer::SWT::GridLayoutProxy
          the_layout_class.new(parent, args)
        end
        
        def layout_class(keyword)
          class_name_alternative = keyword.camelcase(:upper)
          class_name_main = "#{class_name_alternative}Proxy"
          a_layout_class = Glimmer::SWT.const_get(class_name_main.to_sym) rescue Glimmer::SWT.const_get(class_name_alternative.to_sym)
          a_layout_class if a_layout_class.ancestors.include?(Glimmer::SWT::LayoutProxy)
        rescue => e
          puts "Layout #{keyword} was not found!"
          nil
        end
        
        def layout_exists?(keyword)
          !!layout_class(keyword)
        end
      end      
      
      attr_reader :parent, :args
        
      def initialize(parent, args)
        @parent = parent
        @args = args
        @parent.add_css_class(css_class)
      end

      def css_class
        self.class.name.split('::').last.underscore.sub(/_proxy$/, '').gsub('_', '-')
      end
      
      def reapply
        # subclasses can override this
      end
    end
  end
end

require 'glimmer/swt/grid_layout_proxy'
require 'glimmer/swt/fill_layout_proxy'
