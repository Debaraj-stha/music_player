class Tracks {
  int id;
  String link;
  String cover;
  String title;
  String cover_small;
  String cover_medium;
  Artist artist;
  Tracks(
      {required this.id,
      required this.link,
      required this.cover,
      required this.title,
      required this.cover_small,
      required this.artist,
      required this.cover_medium});
  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
      id: json['id'],
      artist: Artist.fromJson(json['artist']),
      link: json['link'],
      cover: json['cover'],
      title: json['title'],
      cover_small: json['cover_small'],
      cover_medium: json['cover_medium']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "artist": artist.toJson(),
        "cover": cover,
        "title": title,
        "cover_small": cover_small,
        "cover_medium": cover
      };
}

class Artist {
  int id;
  String link;
  String picture;
  String name;
  String picture_small;
  String picture_medium;
  Artist(
      {required this.id,
      required this.link,
      required this.picture,
      required this.name,
      required this.picture_small,
      required this.picture_medium});
  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
      id: json['id'],
      link: json['link'],
      name: json['name'],
      picture: json['picture'],
      picture_small: json['picture_small'],
      picture_medium: json['picture_medium']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "picture": picture,
        "picture_small": picture_small,
        "picture_medium": picture,
        "name": name
      };
}

class Track {
  final List<Artists> artists;

  final String id;
  final List<Image> images;
  final String name;

  final String uri;

  Track({
    required this.artists,
    required this.id,
    required this.images,
    required this.name,
    required this.uri,
  });
  factory Track.fromJson(Map<String, dynamic> json) => Track(
      artists: List<Artists>.from(json['user'].map((u) => Artists.fromJson(u))),
      id: json['id'],
      images: List<Image>.from(json['image'].map((i) => Image.fromJson(i))),
      name: json['name'],
      uri: json['uri']);
}

class Artists {
  final String href;
  final String id;
  final String name;

  final String uri;

  Artists({
    required this.href,
    required this.id,
    required this.name,
    required this.uri,
  });
  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
      href: json['href'], id: json['id'], name: json['name'], uri: json['uri']);
}

class Image {
  final int height;
  final String url;
  final int width;

  Image({
    required this.height,
    required this.url,
    required this.width,
  });
  factory Image.fromJson(Map<String, dynamic> json) =>
      Image(height: json['height'], width: json['width'], url: json['width']);
}
