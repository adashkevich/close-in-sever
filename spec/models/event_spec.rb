require 'rails_helper'

RSpec.describe Event, type: :model do

  it 'has a valid factory' do
    expect(Fabricator(:event)).to be_valid
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :title }
    # it { is_expected.to validate_uniqueness_of :email }
    # it { is_expected.to validate_confirmation_of :password }
    # it { is_expected.to validate_presence_of :first_name }
    # it { is_expected.to validate_presence_of :last_name }
  end
end
