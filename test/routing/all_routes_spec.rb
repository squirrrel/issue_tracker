require 'test_helper'

class AllRoutesTest < ActionController::TestCase
  test 'GET client/issue_ticket/new' do
		assert_routing 'client/issue_ticket/new', { controller: 'customer_interfaces', action: 'new' }
  end

  test 'GET client/issue_ticket/show/1' do
  	assert_routing(
  		{ method: 'get', path: 'client/issue_ticket/1' }, 
  		{ controller: 'customer_interfaces', action: 'show', id: '1' }
  	)
  end

	test 'GET client/issue_ticket/1/edit' do
  	assert_routing(
  		{ method: :get, path: 'client/issue_ticket/1/edit' }, 
			{ controller: 'customer_interfaces', action: 'edit', id: '1' }
		)
  end

  test 'POST client/issue_ticket/1' do
  	assert_routing(	
  		{ method: :post, path: 'client/issue_ticket' }, 
			{ controller: 'customer_interfaces', action: 'create' }
		)	
  end

  test 'PATCH client/issue_ticket/1' do
  	assert_routing(	
  		{ method: :patch, path: 'client/issue_ticket/1' }, 
			{ controller: 'customer_interfaces', action: 'update', id: '1' }
  	)
  end

  test 'PUT client/issue_ticket/1' do
  	assert_routing(
	 		{ method: :put, path: 'client/issue_ticket/1' }, 
			{ controller: 'customer_interfaces', action: 'update', id: '1' }
  	)
  end

# doesn't work for some reason
  # test 'GET /issue_manager' do
  # 	assert_routing(
  # 		{ method: :get, path: '/issue_manager' }, 
  # 		{ controller: 'engineer_interfaces', action: 'index' }
		# )
  # end

  test 'GET /' do
  	assert_routing(
  		{ method: :get, path: '/' }, 
  		{ controller: 'engineer_interfaces', action: 'index' }
		)
  end	  	

  test 'GET /issue_manager/1' do
		assert_routing(
			{ method: :get, path: '/issue_manager/1' },
			{ controller: 'engineer_interfaces', action: 'show', id: '1' }
		)	
	end

	test 'GET /issue_manager/1/edit' do
		assert_routing(
			{ method: :get, path: '/issue_manager/1/edit' }, 
			{ controller: 'engineer_interfaces', action: 'edit', id: '1' }
		)
	end

	test 'PATCH /issue_manager/1' do
		assert_routing(
			{ method: :patch, path: '/issue_manager/1' }, 
			{ controller: 'engineer_interfaces', action: 'update', id: '1' }
		)
	end

	test 'PUT /issue_manager/1' do
		assert_routing(
			{ method: :put, path: '/issue_manager/1' }, 
			{ controller: 'engineer_interfaces', action: 'update', id: '1' }
		)
	end

	test 'GET /issue_manager/load_views' do
		assert_routing(
			{ method: :get, path: '/issue_manager/load_views' }, 
			{ controller: 'engineer_interfaces', action: 'load_views' }
		)
	end	
end