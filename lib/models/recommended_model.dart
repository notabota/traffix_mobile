class RecommendedModel {
  String name;
  String tagLine;
  String image;
  List<String> images;
  String description;
  num dist;

  RecommendedModel(this.name, this.tagLine, this.image, this.images,
      this.description, this.dist);
}

List<RecommendedModel> recommendations = recommendationsData
    .map((item) => RecommendedModel(
        item['name'] as String,
        item['tagLine'] as String,
        item['image'] as String,
        item['images'] as List<String>,
        item['description'] as String,
        item['dist'] as num))
    .toList();

var recommendationsData = [
  {
    "name": "Cầu Rồng",
    "tagLine": "Cầu Rồng - Biểu tượng của thành phố Đà Nẵng",
    "image":
        "https://windows10spotlight.com/wp-content/uploads/2021/02/0ea22248094ae7550cec591cc00a9ff4.jpg",
    "images": [
      "https://cdn.vox-cdn.com/thumbor/kyV-zt5RhC5Gb5st_M52cDo3KjQ=/0x0:1100x658/1400x788/filters:focal(550x329:551x330)/cdn.vox-cdn.com/uploads/chorus_asset/file/14292768/dragonbridge.1419979437.jpg",
      "https://hiddenhoian.com/wp-content/uploads/2019/12/Fergus-Vinnels.jpg",
      "https://www.colorkinetics.com/content/dam/color-kinetics/showcases/dragon-bridge/dragon-bridge1_lg.jpg",
      "https://d13jio720g7qcs.cloudfront.net/images/destinations/origin/5f196c70e486a.jpg",
      "https://nuithantai.vn/Content/UserFiles/Images/News/New%20folder%2FSEO%2Fcau-rong-phun-lua.jpg"
    ],
    "description":
        "Là một cây cầu độc đáo tại Việt Nam, cầu Rồng trở thành một biểu tượng của thành phố Đà Nẵng mà không du khách nào có thể bỏ lỡ.",
    "dist": 2.0
  },
  {
    "name": "Cầu sông Hàn",
    "tagLine": "Niềm tự hào của người dân thành phố Đà Nẵng",
    "image":
        "https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/07/cau-quay-song-han-khi-anh-den-ruc-ro.jpg",
    "images": [
      "https://thuexekhatran.com/wp-content/uploads/2019/06/cau-song-han-da-nang-quay-luc-may-gio-4.jpg",
      "http://danang-shopping.com/wp-content/uploads/2016/08/han-river-bridge-da-nang-travel-shopping-guides-3-799x533.jpg",
      "https://halotravel.vn/wp-content/uploads/2021/07/cau-quay-song-han-1.jpg",
      "https://dichvuthuexedanang.com/wp-content/uploads/2019/07/cau-song-han-da-nang-10-min.jpg",
      "https://media.mia.vn/uploads/blog-du-lich/cau-S%C3%B4ng-H%C3%A0n-Ni%E1%BB%81m-t%E1%BB%B1-h%C3%A0o-c%E1%BB%A7a-ng%C6%B0%E1%BB%9Di-d%C3%A2n-%C4%90%C3%A0-N%E1%BA%B5ng-5-1637105536.jpg"
    ],
    "description":
        "Khi nhắc đến Đà Nẵng người ta không thể không nhắc đến sông Hàn thơ mộng và cầu sông Hàn – Chiếc cầu xoay đầu tiên của Việt Nam, là niềm tự hào của người dân thành phố Đà Nẵng",
    "dist": 3.1
  },
  {
    "name": "Vincom Plaza Ngô Quyền",
    "tagLine": "Thiên đường mua sắm, vui chơi và ẩm thực của Thành phố Đà Nẵng",
    "image":
        "https://media.foody.vn/res/g15/147599/prof/s/foody-mobile-banner-03-jpg-792-635712752230674318.jpg",
    "images": [
      "https://images.foody.vn/images/rap(1).jpg",
      "http://danangz.vn/wp-content/uploads/2022/01/nql2988-1580778857557733129554.jpg",
      "https://kenhhomestay.com/wp-content/uploads/2019/12/vincom-da-nang-1.jpg",
      "https://khachsandanang.info/wp-content/uploads/2016/10/vincom_vqsf.jpg",
      "https://images.millenin.com/news/6/item.6_2015/detail/65913_353712_03612_Vincom%20Center%20Danang-2.jpg",
    ],
    "description":
        "Vincom Center là siêu thị mua sắm lớn ở Đà Nẵng, tọa lạc ngay tại chân cầu sông Hàn, là nơi thu hút đông khách du lịch các nước tới thăm quan và mua sắm",
    "dist": 3.2
  },
];
