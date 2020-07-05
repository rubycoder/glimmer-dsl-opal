require 'glimmer/dsl/engine'
# Dir[File.expand_path('../*_expression.rb', __FILE__)].each {|f| require f}
require 'glimmer/dsl/opal/shell_expression'
require 'glimmer/dsl/opal/widget_expression'
require 'glimmer/dsl/opal/property_expression'
require 'glimmer/dsl/opal/bind_expression'
require 'glimmer/dsl/opal/data_binding_expression'
require 'glimmer/dsl/opal/combo_selection_data_binding_expression'
require 'glimmer/dsl/opal/widget_listener_expression'
require 'glimmer/dsl/opal/grid_layout_expression'
require 'glimmer/dsl/opal/list_expression'
require 'glimmer/dsl/opal/browser_expression'
require 'glimmer/dsl/opal/tab_folder_expression'
require 'glimmer/dsl/opal/tab_item_expression'
require 'glimmer/dsl/opal/message_box_expression'
require 'glimmer/dsl/opal/async_exec_expression'
require 'glimmer/dsl/opal/observe_expression'
require 'glimmer/dsl/opal/layout_data_expression'
require 'glimmer/dsl/opal/list_selection_data_binding_expression'
require 'glimmer/dsl/opal/table_expression'
require 'glimmer/dsl/opal/table_column_expression'
require 'glimmer/dsl/opal/table_items_data_binding_expression'
require 'glimmer/dsl/opal/column_properties_expression'

module Glimmer
  module DSL
    module Opal
      Engine.add_dynamic_expressions(
       Opal,
       %w[
         widget_listener
         table_items_data_binding
         combo_selection_data_binding
         list_selection_data_binding
         data_binding
         property
         widget
       ]
      )
    end
  end
end
