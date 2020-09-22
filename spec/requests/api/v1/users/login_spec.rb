require 'rails_helper'

RSpec.describe 'Sessions endpoint' do
  before :each do
    @user = create(:user, email: "whatever@example.com", password: "password")
  end
  it 'can login a user with good credentials' do
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
    }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    parsed = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed[:type]).to eq('user')
    expect(parsed[:id]).to eq(@user.id.to_s)

    attributes = parsed[:attributes]
    expect(attributes.keys).to eq([:email, :api_key])
    expect(attributes[:email]).to eq(@user.email)
    expect(attributes[:api_key]).to eq(@user.api_key)
    expect(attributes[:password]).to be_nil
    expect(attributes[:password_digest]).to be_nil
    expect(attributes[:password_confirmation]).to be_nil
  end
  it "won't accept a bad email address" do
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "email": "ughhh@example.com",
      "password": "password",
    }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors]).to eq('Invalid email')
    expect(parsed[:id]).to be_nil
    expect(parsed[:attributes]).to be_nil
  end
  it "won't accept a bad password" do
    headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    user_params = {
      "email": "whatever@example.com",
      "password": "obviouslywrong",
    }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json')

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors]).to eq('Incorrect password')
    expect(parsed[:id]).to be_nil
    expect(parsed[:attributes]).to be_nil
  end

end
