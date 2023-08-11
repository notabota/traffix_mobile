import 'package:flutter/material.dart';
import 'package:traffix/models/planets.dart';
import 'package:traffix/pages/widgets/cameras_summary.dart';

class CamerasBody extends StatelessWidget {
  const CamerasBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color(0xFF736AB7),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => CamerasSummary(planet: planets[index]),
                  childCount: planets.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
