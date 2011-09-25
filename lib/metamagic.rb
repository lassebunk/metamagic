require 'metamagic/helper_methods'

ActionController::Base.send :include, Metamagic::HelperMethods
ActionView::Base.send :include, Metamagic::HelperMethods