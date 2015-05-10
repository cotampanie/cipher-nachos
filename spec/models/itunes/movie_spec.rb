require 'rails_helper'

describe Itunes::Movie do
  SEARCH_TERM = 'Avengers'
  TRACK_ID = 1
  TRACK_NAME = 'Avengers: Age of Ultron'

  describe '#search' do

    before do
      stub_api_for(Itunes::Movie) do |stub|
        stub.get("/search?entity=movie&term=#{SEARCH_TERM}") do |env|
          [200, {}, [{ trackId: TRACK_ID, trackName: TRACK_NAME}].to_json]
        end
      end
    end

    it 'should return results for specified term' do
      movies = Itunes::Movie.search(SEARCH_TERM)

      expect(movies.size).to eq 1
      expect(movies[0].track_id).to eq TRACK_ID
      expect(movies[0].track_name).to eq TRACK_NAME
    end

  end

  describe '#find_by_id' do

    before do
      stub_api_for(Itunes::Movie) do |stub|
        stub.get("/lookup?id=#{TRACK_ID}") do |env|
          [200, {}, [{ trackId: TRACK_ID, trackName: TRACK_NAME}].to_json]
        end
      end
    end

    context 'id as a single value' do

      it 'should return movie details for specified id' do
        movies = Itunes::Movie.find_by_id(TRACK_ID)

        expect(movies.size).to eq 1
        expect(movies[0].track_id).to eq TRACK_ID
        expect(movies[0].track_name).to eq TRACK_NAME
      end

    end

    context 'id as a array' do

      it 'should return movie details for specified ids' do
        movies = Itunes::Movie.find_by_id([TRACK_ID])

        expect(movies.size).to eq 1
        expect(movies[0].track_id).to eq TRACK_ID
        expect(movies[0].track_name).to eq TRACK_NAME
      end

    end

  end

  describe '.photo_url' do

    ORIGINAL_URL = 'http://is5.mzstatic.com/image/Interstellar_FTO_Pre-Sale_1400x2100.100x100-75.jpg'
    EXPECTED_URL = 'http://is5.mzstatic.com/image/Interstellar_FTO_Pre-Sale_1400x2100.250x250-75.jpg'

    it 'should return url with proper resolution' do
      movie = Itunes::Movie.new artworkUrl100: ORIGINAL_URL

      expect(movie.photo_url).to eq(EXPECTED_URL)
    end

  end

end