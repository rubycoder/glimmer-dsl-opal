# Copyright (c) 2020 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'glimmer/swt/widget_proxy'

module Glimmer
  module SWT
    class TabFolderProxy < WidgetProxy
      attr_reader :tabs
      
      def initialize(parent, args, block)
        super(parent, args, block)
        @tabs = []
      end
      
      def post_initialize_child(child)
        unless @children.include?(child)
          @children << child
          tabs_dom_element.append(child.tab_dom)
          child.render
        end
        
        if @children.size == 1
          child.show
        end
      end
      
      def hide_all_tab_content
        @children.each(&:hide)
      end
    
      def tabs_path
        path + " > ##{tabs_id}"
      end
      
      def tabs_id
        id + '-tabs'
      end
      
      def tabs_dom_element
        Document.find(tabs_path)
      end
      
      def dom
        tab_folder_id = id
        tab_folder_id_style = css
        @dom ||= html {
          div(id: tab_folder_id, style: tab_folder_id_style, class: 'tab-folder') {
            div(id: tabs_id, class: 'tabs')
          }
        }.to_s
      end
    end
  end
end
