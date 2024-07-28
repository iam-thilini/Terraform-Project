# Data blocks for each artist with a larger limit to accommodate more tracks
data "spotify_search_track" "pitbull" {
  artist = "Pitbull"
  limit = 9
}

data "spotify_search_track" "drake" {
  artist = "Drake"
  limit = 1
}

data "spotify_search_track" "david_guetta" {
  artist = "David Guetta"
  limit = 5
}

data "spotify_search_track" "dua_lipa" {
  artist = "Dua Lipa"
  limit = 5
}

data "spotify_search_track" "calvin_harris" {
  artist = "Calvin Harris"
  limit = 5
}

data "spotify_search_track" "dj_snake" {
  artist = "DJ Snake"
  limit = 10
}

data "spotify_search_track" "shaggy" {
  artist = "Shaggy"
  limit = 5
}

data "spotify_search_track" "conkarah" {
  artist = "Conkarah"
  limit = 1
}

data "spotify_search_track" "daddy_yankee" {
  artist = "Daddy Yankee"
  limit = 10
}

data "spotify_search_track" "jay_sean" {
  artist = "Jay Sean"
  limit = 2
}

data "spotify_search_track" "beyonce" {
  artist = "Beyoncé"
  limit = 2
}

data "spotify_search_track" "sia" {
  artist = "Sia"
  limit = 5
}

data "spotify_search_track" "sean_paul" {
  artist = "Sean Paul"
  limit = 5
}

data "spotify_search_track" "avicii" {
  artist = "Avicii"
  limit = 4
}



# Combine and remove duplicates
locals {
  all_tracks = flatten([
    data.spotify_search_track.pitbull.tracks,
    data.spotify_search_track.drake.tracks,
    data.spotify_search_track.david_guetta.tracks,
    data.spotify_search_track.dua_lipa.tracks,
    data.spotify_search_track.calvin_harris.tracks,
    data.spotify_search_track.dj_snake.tracks,
    data.spotify_search_track.shaggy.tracks,
    data.spotify_search_track.conkarah.tracks,
    data.spotify_search_track.daddy_yankee.tracks,
    data.spotify_search_track.jay_sean.tracks,
    data.spotify_search_track.beyonce.tracks,
    data.spotify_search_track.sia.tracks,
    data.spotify_search_track.sean_paul.tracks,
    data.spotify_search_track.avicii.tracks,
  ])

  unique_tracks = distinct([for track in local.all_tracks : track.id])
}

# Create the workout playlist
resource "spotify_playlist" "workout_playlist" {
  name        = "Workout Playlist"
  description = "Energetic tracks for a great workout session"
  public      = false

  tracks = local.unique_tracks
}
