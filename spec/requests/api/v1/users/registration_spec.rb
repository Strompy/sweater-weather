require 'rails_helper'

RSpec.describe 'Users Endpoint' do
  it 'can create a user with good params' do
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    expect(User.count).to eq(0)

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json')

    expect(User.count).to eq(1)
    user = User.last

    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed[:type]).to eq('users')
    expect(parsed[:id]).to eq(user.id)

    attributes = parsed[:attributes]
    expect(attributes[:email]).to eq(user.email)
    expect(attributes[:api_key]).to eq(user.api_key)
  end
  it 'wont accept a duplicate email' do
    # expect(response.status).to eq(400)
  end
  it 'wont accept a mismatched password' do
    # expect(response.status).to eq(400)

  end
  it 'wont accept a missing details' do
    # expect(response.status).to eq(400)

  end
end
