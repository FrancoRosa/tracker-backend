require 'rails_helper'

RSpec.describe Record, type: :model do
  it { should belong_to(:track) }
  it { should validate_presence_of(:value) }
end


