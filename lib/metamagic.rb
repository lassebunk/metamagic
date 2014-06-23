%w{
  version
  tag
  tags/meta_tag
  tags/title_tag
  tags/property_tag
  tags/custom_tag
  renderer
  view_helper
}.each { |f| require "metamagic/#{f}" }

ActionView::Base.send :include, Metamagic::ViewHelper