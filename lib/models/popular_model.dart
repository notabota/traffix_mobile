class PopularModel {
  String image;
  int color;
  int textColor;

  PopularModel(this.image, this.color, this.textColor);
}

List<PopularModel> populars = popularsData
    .map((item) => PopularModel(item['image'] as String, item['color'] as int,
        item['text_color'] as int))
    .toList();

var popularsData = [
  {
    "image": "assets/imgs/img_beach.png",
    "color": 0xFFFEF1ED,
    "text_color": 0xFFf24e1c
  },
  {
    "image": "assets/imgs/img_mountain.png",
    "color": 0xFFEDF6FE,
    "text_color": 0xFF1389f1
  },
  {
    "image": "assets/imgs/img_lake.png",
    "color": 0xFFFEF6E8,
    "text_color": 0xFFf6ae31
  },
  {
    "image": "assets/imgs/img_river.png",
    "color": 0xFFEAF8E8,
    "text_color": 0xFF61ca53
  },
];
