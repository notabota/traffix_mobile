import 'package:flutter/material.dart';
import 'package:traffix/models/navigation_details_model.dart';
import 'package:traffix/ui/global.dart';
import 'package:traffix/pages/widgets/widgets.dart';

class Navigation extends StatelessWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(Icons.map, color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child:
                        const Icon(Icons.person_pin_circle, color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.orangeAccent]),
                        borderRadius: BorderRadius.circular(9.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.orange,
                              blurRadius: 3.0,
                              offset: Offset(0, 3)),
                        ],
                      ),
                      child: const Icon(
                        Icons.confirmation_number,
                        color: Colors.white,
                      )),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(Icons.location_city, color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: lightGreen,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Depart at: ",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.79),
                            fontSize: 15.0),
                      ),
                      const DepartureSelector(),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text(
                          "Filters",
                          style:
                              TextStyle(color: Colors.white.withOpacity(.85)),
                        ),
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white.withOpacity(.85),
                        ),
                      )
                    ],
                  ),
                  LocationSelectorContainer(),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -5),
                      blurRadius: 9,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const MeansTransportMenu(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: navigationRoute.length,
                        itemBuilder: (ctx, i) {
                          return TicketContainer(
                            navigationDetails: navigationRoute[i],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<CarNavigationDetailsModel> navigationRoute = [
    CarNavigationDetailsModel(distance: '20', eta: '40', note1: 'Hey', road: []),
    CarNavigationDetailsModel(distance: '30', eta: '50', note2: 'Yo', road: []),
  ];
}
