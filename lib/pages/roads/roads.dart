import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffix/pages/widgets/appbar.dart';
import 'package:traffix/pages/widgets/featuredcard.dart';
import 'package:traffix/pages/widgets/travelplacedart.dart';
import 'package:traffix/constants/colors.dart';
import 'package:traffix/ui/theme.dart';
import 'package:traffix/pages/widgets/featurelist.dart';
import 'package:traffix/pages/roads/state/homepage_state_provider.dart';
import 'package:traffix/pages/roads/roads_details.dart';

class Roads extends StatefulWidget {
  const Roads({Key? key}) : super(key: key);

  @override
  RoadsState createState() => RoadsState();
}

class RoadsState extends State<Roads> {
  final ScrollController _mainScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomePageStateProvider homepagestate =
        Provider.of<HomePageStateProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _mainScrollController,
              child: Column(
                children: [
                  const TopFeaturedList(),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.33,
                    child: StreamBuilder(
                        stream: homepagestate.getFeaturedPlaces().asStream(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: const CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: const CircularProgressIndicator());
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RoadsDetails()));
                                    },
                                    child: FeaturedCard(
                                      placeModel: snapshot.data[index],
                                    ));
                              });
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "   Recommended",
                          style: kAppTheme.textTheme.headline5,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: kAppTheme.textTheme.headline6,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: StreamBuilder(
                        stream: homepagestate.getAllPlaces().asStream(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: const CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: const CircularProgressIndicator());
                          }

                          return GridView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RoadsDetails()));
                                    },
                                    child: travelCard(snapshot.data?[index]));
                              });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
