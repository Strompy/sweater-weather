require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end
  it 'attributes' do
    user = User.create!(
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user.api_key).to_not be_nil
  end
end
