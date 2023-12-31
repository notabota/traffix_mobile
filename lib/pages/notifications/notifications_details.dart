import 'package:traffix/models/lesson.dart';
import 'package:flutter/material.dart';

class NotificationsDetails extends StatelessWidget {
  final Lesson lesson;

  const NotificationsDetails({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levelIndicator = LinearProgressIndicator(
        backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
        value: lesson.indicatorValue,
        valueColor: const AlwaysStoppedAnimation(Colors.green));

    final coursePrice = Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        "\$${lesson.price}",
        style: const TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 80.0),
        const Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 40.0,
        ),
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        const SizedBox(height: 10.0),
        Text(
          lesson.title,
          style: const TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      lesson.level,
                      style: const TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/drive-steering-wheel.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      lesson.content,
      style: const TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(58, 66, 86, 1.0),
          ),
          child: const Text("TAKE THIS LESSON",
              style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
