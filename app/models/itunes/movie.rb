module Itunes
  class Movie
    include Her::Model

    collection_path '/search'
    resource_path '/search'

    attributes :trackId, :artistName, :trackName, :trackViewUrl, :trackHdPrice, :shortDescription,
               :longDescription, :artworkUrl100
    alias_method :track_id, :trackId
    alias_method :artist_name, :artistName
    alias_method :track_name, :trackName
    alias_method :track_view_url, :trackViewUrl
    alias_method :track_hd_price, :trackHdPrice
    alias_method :short_description, :shortDescription
    alias_method :long_description, :longDescription
    alias_method :artwork_url_100, :artworkUrl100

    def self.search(term)
      all({entity: 'movie', term: term})
    end

    def self.find_by_id(ids)
      get('/lookup', {id: (ids.is_a?(Array) ? ids.join(',') : ids)})
    end

    def photo_url
      artwork_url_100.gsub('100x100-75', '250x250-75')
    end
  end
end
