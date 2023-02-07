class DeleteJob < ApplicationJob
	queue_as :default

	def perform(id)
		Employee.find(id).update(entry: 0)
	end
end