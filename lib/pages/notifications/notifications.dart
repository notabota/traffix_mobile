import 'package:traffix/models/lesson.dart';
import 'package:flutter/material.dart';
import 'package:traffix/pages/notifications/notifications_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key, this.title = "Nice"}) : super(key: key);

  final String title;

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  late List lessons;

  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('notifications').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Lesson lesson) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: const Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            lesson.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: LinearProgressIndicator(
                      backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
                      value: lesson.indicatorValue,
                      valueColor: const AlwaysStoppedAnimation(Colors.green))),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(lesson.level,
                        style: const TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsDetails(lesson: lesson)));
          },
        );

    Card makeCard(Lesson lesson) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson),
          ),
        );

    return StreamBuilder<QuerySnapshot>(
        stream: collectionStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          lessons = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> lessonsData =
                document.data()! as Map<String, dynamic>;
            return Lesson(
              title: lessonsData["title"],
              content: lessonsData["content"],
              indicatorValue: lessonsData["indicatorValue"] ?? 0,
              price: lessonsData["price"] ?? 0,
              level: lessonsData["level"],
            );
          }).toList();

          print("Mylessons $lessons");

          return Scaffold(
            backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
            appBar: AppBar(
              elevation: 0.1,
              backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
              title: Text(widget.title),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {},
                )
              ],
            ),
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lessons.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(lessons[index]);
              },
            ),
            bottomNavigationBar: SizedBox(
              height: 55.0,
              child: BottomAppBar(
                color: const Color.fromRGBO(58, 66, 86, 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.blur_on, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.hotel, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_box, color: Colors.white),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

// List getLessons = [
//   Lesson(
//       title: "Introduction to Driving",
//       level: "Beginner",
//       indicatorValue: 0.33,
//       price: 20,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//   Lesson(
//       title: "Observation at Junctions",
//       level: "Beginner",
//       indicatorValue: 0.33,
//       price: 50,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//   Lesson(
//       title: "Reverse parallel Parking",
//       level: "Intermidiate",
//       indicatorValue: 0.66,
//       price: 30,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//   Lesson(
//       title: "Reversing around the corner",
//       level: "Intermidiate",
//       indicatorValue: 0.66,
//       price: 30,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//   Lesson(
//       title: "Incorrect Use of Signal",
//       level: "Advanced",
//       indicatorValue: 1.0,
//       price: 50,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//   Lesson(
//       title: "Engine Challenges",
//       level: "Advanced",
//       indicatorValue: 1.0,
//       price: 50,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//   Lesson(
//       title: "Self Driving Car",
//       level: "Advanced",
//       indicatorValue: 1.0,
//       price: 50,
//       content:
//           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
// ];
