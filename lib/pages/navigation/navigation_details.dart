import 'package:flutter/material.dart';
import 'package:traffix/models/navigation_details_model.dart';
import 'package:traffix/ui/global.dart';
import 'package:traffix/pages/widgets/widgets.dart';

class NavigationDetails extends StatelessWidget {
  NavigationDetails({
    Key? key,
    required this.navigationDetails,
  }) : super(key: key);

  CarNavigationDetailsModel navigationDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(9.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.green,
                          blurRadius: 3.0,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: const Icon(Icons.map, color: Colors.white),
                ),
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(9.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.blue,
                          blurRadius: 3.0,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: const Icon(Icons.star, color: Colors.white),
                ),
              ),
            ),
            Expanded(
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
                  child: Text(
                    "Di chuyển",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.apply(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[400]),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(0, 9),
                    color: lightGreen.withOpacity(.75),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.asset('assets/imgs/invoice.png'),
                  ),
                  const SizedBox(width: 15.0),
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: const <Widget>[
                        Text(
                          "Buying tickets is now much more comfortable.",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Buy a ticket now and get 50% discount.",
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            MyMap(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const LocationRow(
                        color: Colors.blue,
                        icon: Icon(
                          Icons.arrow_drop_up,
                          color: Colors.white,
                          size: 25,
                        ),
                        location: "Trần Hưng Đạo",
                        time: "Ổn định",
                      ),
                      LocationRow(
                        color: Colors.white,
                        location: "Nguyễn Văn Thoại",
                        time: "Văng",
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      const LocationRow(
                        color: Colors.orange,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 25,
                        ),
                        location: "Ngô Quyền",
                        time: "Giờ cao điểm",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      color: const Color(0xfffcfcfd),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.grey[200]!,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "05",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 41),
                        ),
                        Text(
                          "phút",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 25),
                        ),
                        const SizedBox(
                          height: 9.0,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.grey),
                            children: [
                              const TextSpan(
                                text: "Đến lúc: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: "7:30",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.apply(
                                          color: darkBlue, fontWeightDelta: 2)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  "Ngô Quyền",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
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
                                        borderRadius:
                                            BorderRadius.circular(9.0),
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
                            const SizedBox(width: 9),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  "Trần Hưng Đạo",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
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
                                        borderRadius:
                                            BorderRadius.circular(9.0),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
