import 'package:flutter/material.dart';
import 'package:traffix/models/planets.dart';
import 'package:traffix/pages/widgets/separator.dart';
import 'package:traffix/pages/cameras/cameras_details.dart';
import 'package:traffix/ui/text_style.dart';

class CamerasSummary extends StatelessWidget {
  final Planet planet;
  final bool horizontal;

  const CamerasSummary({Key? key, required this.planet, this.horizontal = true})
      : super(key: key);

  const CamerasSummary.vertical({Key? key, required this.planet})
      : horizontal = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: Hero(
        tag: "planet-hero-${planet.id}",
        child: Image(
          image: AssetImage(planet.image),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    Widget _planetValue({required String value, required String image}) {
      return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Image.asset(image, height: 12.0),
        Container(width: 8.0),
        Text(planet.gravity, style: Style.smallTextStyle),
      ]);
    }

    final planetCardContent = Container(
      margin: EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(planet.name, style: Style.titleTextStyle),
          Container(height: 10.0),
          Text(planet.location, style: Style.commonTextStyle),
          const Separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _planetValue(
                      value: planet.distance,
                      image: 'assets/imgs/ic_distance.png')),
              Container(
                width: horizontal ? 8.0 : 32.0,
              ),
              Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _planetValue(
                      value: planet.gravity,
                      image: 'assets/imgs/ic_gravity.png'))
            ],
          ),
        ],
      ),
    );

    final planetCard = Container(
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? const EdgeInsets.only(left: 46.0)
          : const EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: const Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: planetCardContent,
    );

    return GestureDetector(
        onTap: horizontal
            ? () => Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CamerasDetails(planet: planet),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                )
            : null,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: Stack(
            children: <Widget>[
              planetCard,
              planetThumbnail,
            ],
          ),
        ));
  }
}
