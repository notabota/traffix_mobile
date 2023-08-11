import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:place_picker/place_picker.dart';

class LocationSelectorContainer extends StatefulWidget {
  const LocationSelectorContainer({Key? key}) : super(key: key);

  @override
  LocationSelectorContainerState createState() =>
      LocationSelectorContainerState();
}

class LocationSelectorContainerState extends State<LocationSelectorContainer> {
  String? start;
  String? end;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(.3),
                        border: Border.all(color: Colors.blue, width: 3.0),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Từ",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.apply(color: Colors.black38),
                        ),
                        GestureDetector(
                            child: Text(
                              start ?? 'Điểm khởi hành',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.apply(color: Colors.black87),
                            ),
                            onTap: () async {
                              LocationResult result = await Navigator.of(
                                      context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                          dotenv.env['GOOGLE_MAP_API_KEY']!)));

                              if (result != null) {
                                setState(() {
                                  start = result.formattedAddress;
                                });
                              }
                            }),
                      ],
                    )
                  ],
                ),
                const Divider(
                  height: 25,
                  color: Colors.black,
                  thickness: .7,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withOpacity(.3),
                        border: Border.all(color: Colors.orange, width: 3.0),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Đến",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.apply(color: Colors.black38),
                        ),
                        GestureDetector(
                            child: Text(
                              end ?? 'Điểm kết thúc',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.apply(color: Colors.black87),
                            ),
                            onTap: () async {
                              LocationResult result = await Navigator.of(
                                      context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                          dotenv.env['GOOGLE_MAP_API_KEY']!)));

                              if (result != null) {
                                setState(() {
                                  end = result.formattedAddress;
                                });
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xfff0f3f7),
                borderRadius: BorderRadius.circular(5.0)),
            child: IconButton(
              icon: const Icon(
                Icons.import_export,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
