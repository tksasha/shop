module ApplicationHelper
  def breadcrumbs
    content_tag :ol, class: 'breadcrumb' do
      concat content_tag :li, link_to('Root', :root), class: 'breadcrumb-item'

      yield if block_given?
    end
  end
end
