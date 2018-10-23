module NavigationHelper

	def activate_route(named_route)
		return ' active' if active?(named_route)
	end

	def active?(named_route)
		self.controller_name == named_route
	end

end