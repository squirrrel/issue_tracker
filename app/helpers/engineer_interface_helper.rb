module EngineerInterfaceHelper
	def get_view_status_hash
		{ 
			:"New unassigned tickets" => :'Waiting for Staff Response', 
			:"Open tickets" => :'Waiting for Customer', 
			:"On hold tickets" => :'On Hold', 
			:"Closed tickets" => [:'Cancelled',:'Completed']
		}
	end

	def get_status_array
		[:'Waiting for Staff Response', :'Waiting for Customer', :'On Hold', :'Cancelled', :'Completed']
	end	
end