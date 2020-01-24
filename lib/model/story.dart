enum Feels {
  awesome,
  good,
  general,
  disappointing,
}

class Story {
  int id;
  int mediaId;
  DateTime createDate;
  DateTime updateDate;
  DateTime watchDate;
  String feel;
  double rate;
  String review;

  Story({
    this.id,
    this.mediaId,
    this.createDate,
    this.updateDate,
    this.watchDate,
    this.feel = 'general',
    this.rate = 5.0,
    this.review = 'nothing to say.',
  });
}
