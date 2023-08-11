import 'package:traffix/models/places_model.dart';

class RESTAPI {
  List<PlaceModel> dummyFeatured = [
    PlaceModel(
      placeTitle: "Ngô Quyền",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 5,
      imgUrl: "https://mt.gov.vn/Images/editor/images/HOA/2019/cai-tao-duong.jpg",
    ),
    PlaceModel(
      placeTitle: "Trần Hưng Đạo",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 6,
      imgUrl: "https://baodanang.vn/dataimages/202102/original/images1597446_2.jpg",
    ),
    PlaceModel(
      placeTitle: "Nguyễn Văn Linh",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 7,
      imgUrl: "https://anhsangvacuocsong.vn/wp-content/uploads/2019/05/%C4%90%C6%B0%E1%BB%9Dng-Nguy%E1%BB%85n-V%C4%83n-LinhB%E1%BA%A1ch-%C4%90%E1%BA%B1ng-%C4%90%C3%A0-N%E1%BA%B5ng..jpg",
    ),
    PlaceModel(
      placeTitle: "Hồ Nghinh",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 5,
      imgUrl: "https://sites.google.com/site/datbiendn/_/rsrc/1440369006167/home/ban-dat-duong-ho-nghinh/hn2.jpg",
    )
  ];

  List<PlaceModel> dummyAllPlaces = [
    PlaceModel(
      placeTitle: "Vũ Văn Dũng",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 7,
      imgUrl: "https://media.foody.vn/res/g15/143040/prof/s630x400/foody-mobile-quy6-jpg-628-635696367547270455.jpg",
    ),
    PlaceModel(
      placeTitle: "Hà Thị Thân",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 5,
      imgUrl: "https://toprealty.vn/mp-up/2018/09/nha-2mt-ha-thi-than.jpg",
    ),
    PlaceModel(
      placeTitle: "Lê Hữu Trác",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 5,
      imgUrl: "https://filesdata.cadn.com.vn/filedatacadn/media//data_news/Image/2015/th12/ng25/91.jpg",
    ),
    PlaceModel(
      placeTitle: "Võ Văn Kiệt",
      description:
          "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      duration: 6,
      imgUrl: "https://cdn.vietnambiz.vn/171464876016439296/2021/7/23/7f9138a92ac8dd9684d9-162702917538810030355.jpg",
    ),
  ];

  Future<List<PlaceModel>> getFeaturedPlaces() async {
    await Future.delayed(const Duration(milliseconds: 750));
    return dummyFeatured;
  }

  Future<List<PlaceModel>> getAllPlaces() async {
    await Future.delayed(const Duration(milliseconds: 950));
    return dummyAllPlaces;
  }
}
