module Metamagic
  class TwitterTag < PropertyTag
    def property_key
      :name
    end

    def remove_prefix?
      false
    end
  end
end
