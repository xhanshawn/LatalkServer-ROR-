class SayController < ApplicationController
  def hello
  	@time = Time.now
  end

  def goodbye 
  	if $count >0 
  		$count = $count +1
  	else 
  		$count = 0
  	end
  end
end
