%w{
  version
  tag
  tags/meta_tag
  tags/title_tag
  tags/property_tag
  tags/link_tag
  tags/custom_tag
  tags/open_graph_tag
  tags/twitter_tag
  renderer
  view_helper
}.each { |f| require "metamagic/#{f}" }

ActionView::Base.send :include, Metamagic::ViewHelper