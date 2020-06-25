require 'glimmer/opal/element_proxy'

module Glimmer
  module Opal
    class TableItem < ElementProxy
      attr_reader :data
      
      def initialize(parent, args)
        super(parent, args)
        on_widget_selected { |event|
          parent.select(parent.index_of(self), event.meta?)
        }
      end
      
      def dispose
        @dom.remove
      end

      def get_text(index)
        text_array[index]
      end
      
      def set_text(index, text_value)
        text_array[index] = text_value
        redraw
      end
      
      def text_array
        @text_array ||= []
      end

      def get_data(key = nil)
        if key.nil?
          @data
        else
          data_hash[key]
        end
      end
      
      def set_data(key = nil, data_value)
        if key.nil?
          @data = data_value
        else
          data_hash[key] = data_value
        end
      end
      
      def data_hash
        @data_hash ||= {}
      end
      
      def name
        'tr'
      end
      
      def on_widget_selected(&block)
        event = 'click'
        delegate = $document.on(event, selector, &block)
        EventListenerProxy.new(element_proxy: self, event: event, selector: selector, delegate: delegate)
      end
      
      def dom
        table_item_id = id
        table_item_id_style = css
        table_item_css_classes = css_classes
        table_item_selection = parent.selection.include?(self)
        if table_item_selection
          table_item_css_classes << 'selected'
        else
          table_item_css_classes.delete('selected')
        end
        table_item_text_array = text_array
        @dom ||= DOM {
          tr(id: table_item_id, style: table_item_id_style, class: table_item_css_classes.to_a.join(' ')) {
            table_item_text_array.each do |table_item_text|
              td {
                table_item_text
              }
            end
          }
        }
      end
    end
  end
end
