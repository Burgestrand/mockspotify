require 'ffi'
require 'rbconfig'
require 'mockspotify/version'

module Spotify
  module Mock
    # @return [String] path to the libmockspotify C extension binary.
    def self.path
      File.expand_path('../../ext/libmockspotify.', __FILE__) << Config::MAKEFILE_CONFIG['DLEXT']
    end

    # Overridden to always ffi_lib the mock path.
    def ffi_lib(*)
      super(Mock.path)
    end

    # Overriden to not throw an error on missing functions.
    def attach_function(*)
      super
    rescue FFI::NotFoundError => e
      warn "#{e.message}" if $VERBOSE
    end
  end

  extend FFI::Library
  extend Mock
  require 'spotify'

  old_verbose, $VERBOSE = $VERBOSE, true

  attach_function :mock_user, :mocksp_user_create, [:string, :string, :string, :string, :relation_type, :bool], :user
  attach_function :mock_track, :mocksp_track_create, [:string, :int, :array, :pointer, :int, :int, :int, :int, :error, :bool], :track
  attach_function :mock_image, :mocksp_image_create, [:image_id, :imageformat, :size_t, :buffer_in, :error], :image
  attach_function :mock_artist, :mocksp_artist_create, [:string, :bool], :artist
  attach_function :mock_album, :mocksp_album_create, [:string, :artist, :int, :image_id, :albumtype, :bool, :bool], :album

  attach_function :mock_artistbrowse, :mocksp_artistbrowse_create, [:artist, :bool], :artistbrowse

  attach_function :mock_playlist_event, :mocksp_playlist_event, [:int, :playlist], :void

  $VERBOSE = old_verbose
end
