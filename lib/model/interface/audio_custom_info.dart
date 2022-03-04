class AudioCustomInfo {
  String? artist;
  String? title;
  String? duration;

  AudioCustomInfo({this.artist, this.duration, this.title});

  @override
  Map<String, dynamic> toJson() {
    return {"artist": artist, "duration": duration, "title": title};
  }
}
