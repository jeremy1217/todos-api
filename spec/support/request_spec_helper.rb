module RequestSpecHelper
	# Parse JSON response to ruby hash
	def json
		JOSN.parse(response.body)
	end
end