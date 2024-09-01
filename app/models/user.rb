class User < ApplicationRecord

  def foo
    DataApi::SomeService.call
  end
end
