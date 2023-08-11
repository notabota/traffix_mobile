import 'package:flutter/material.dart';
import 'package:traffix/ui/global.dart';
import 'package:traffix/models/navigation_details_model.dart';
import 'package:traffix/pages/navigation/navigation_details.dart';

class TicketContainer extends StatelessWidget {
  TicketContainer({
    Key? key,
    required this.navigationDetails,
  }) : super(key: key);

  CarNavigationDetailsModel navigationDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Khoảng cách"),
                    const SizedBox(
                      height: 5.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: navigationDetails.distance,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          TextSpan(
                              text: " km",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "ETA: ",
                              style: TextStyle(color: Colors.black87)),
                          TextSpan(
                              text: navigationDetails.eta,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Ngô Quyền",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.traffic,
                                  color: Colors.black54,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 9.0),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(9.0),
                                  ),
                                  child: const Text(
                                    "!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Trần Hưng Đạo",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.traffic,
                                  color: Colors.black54,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 9.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(9.0),
                                  ),
                                  child: const Text(
                                    "!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  navigationDetails.note1 != null
                      ? Row(
                          children: <Widget>[
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.withOpacity(.3),
                                border:
                                    Border.all(color: Colors.blue, width: 3.0),
                              ),
                            ),
                            const SizedBox(
                              width: 9.0,
                            ),
                            Text(navigationDetails.note1!,
                                style: Theme.of(context).textTheme.subtitle1)
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  navigationDetails.note2 != null
                      ? Row(
                          children: <Widget>[
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange.withOpacity(.3),
                                border: Border.all(
                                    color: Colors.orange, width: 3.0),
                              ),
                            ),
                            const SizedBox(
                              width: 9.0,
                            ),
                            Text(navigationDetails.note2!,
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        )
                      : Container(),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreen,
                ),
                icon:
                    const Icon(Icons.confirmation_number, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NavigationDetails(
                        navigationDetails: navigationDetails,
                      );
                    },
                  ),
                ),
                label: Text(
                  "Di chuyển",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.apply(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
