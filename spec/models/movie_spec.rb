require 'rails_helper'

describe Movie, type: :model do

  describe 'validations' do

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :track_id }

    context 'for a new movie' do

      it 'should not be valid without a track_id' do
        movie = FactoryGirl.build(:movie, track_id: nil)
        expect(movie).to_not be_valid
      end

      it 'should not be valid without a user_id' do
        movie = FactoryGirl.build(:movie, user_id: nil)
        expect(movie).to_not be_valid
      end

    end

    context 'for an existing movie' do

      let(:movie) { FactoryGirl.create(:movie) }

      it 'should be valid with no changes' do
        expect(movie).to be_valid
      end

    end



  end

end
