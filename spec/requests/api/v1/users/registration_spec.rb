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

    expect(parsed[:type]).to eq('user')
    expect(parsed[:id]).to eq(user.id.to_s)

    attributes = parsed[:attributes]
    expect(attributes.keys).to eq([:email, :api_key])
    expect(attributes[:email]).to eq(user.email)
    expect(attributes[:api_key]).to eq(user.api_key)
    expect(attributes[:password]).to be_nil
    expect(attributes[:password_digest]).to be_nil
    expect(attributes[:password_confirmation]).to be_nil
  end
  it 'wont accept a duplicate email' do
    og_user = create(:user, email: "whatever@example.com")
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    expect(User.count).to eq(1)
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(400)
    expect(response.content_type).to eq('application/json')

    expect(User.count).to eq(1)
    user = User.last
    expect(user).to eq(og_user)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors]).to eq('Email has already been taken')
    expect(parsed[:id]).to be_nil
    expect(parsed[:attributes]).to be_nil
  end
  it 'wont accept a mismatched password' do
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "wrongpassword"
    }

    expect(User.count).to eq(0)
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(400)
    expect(response.content_type).to eq('application/json')

    expect(User.count).to eq(0)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors]).to eq("Password confirmation doesn't match Password")
    expect(parsed[:id]).to be_nil
    expect(parsed[:attributes]).to be_nil
  end
  it 'wont accept a missing details' do
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "password": "password"
    }

    expect(User.count).to eq(0)
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(400)
    expect(response.content_type).to eq('application/json')

    expect(User.count).to eq(0)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors]).to eq("Email can't be blank and Password confirmation can't be blank")
    expect(parsed[:id]).to be_nil
    expect(parsed[:attributes]).to be_nil
  end
end
