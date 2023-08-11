import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traffix/pages/widgets/button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class ApiImage {
  final String imageUrl;
  final String id;

  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class Report extends StatefulWidget {
  const Report({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> {
  bool checkedValue = false;

  final titleKey = GlobalKey<FormState>();
  final descriptionKey = GlobalKey<FormState>();
  final typeKey = GlobalKey<FormState>();
  final imageKey = GlobalKey<FormState>();

  XFile? imageFile;
  final Reference reportImageStorageRef =
      FirebaseStorage.instance.ref('reports/images');
  final CollectionReference reportFirestore =
      FirebaseFirestore.instance.collection('reports');

  Map<String, String> textfieldsStrings = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.light;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff151f2c) : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Align(
                          child: Text(
                            'Báo cáo',
                            style: GoogleFonts.poppins(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015,
                          horizontal: 20,
                        ),
                        child: Align(
                            child: Text(
                          widget.location,
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xff1D1617),
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      buildTextField(
                        "Tiêu đề",
                        Icons.person_outlined,
                        EdgeInsets.only(top: size.height * 0.025),
                        size,
                        titleKey,
                        "title",
                      ),
                      Form(
                        child: buildTextField(
                          "Nội dung",
                          Icons.email_outlined,
                          EdgeInsets.only(top: size.height * 0.025),
                          Size(size.width, size.height * 2),
                          descriptionKey,
                          "description",
                        ),
                      ),
                      Form(
                        child: buildDropdownField(
                          "Phân loại",
                          Icons.lock_outline,
                          EdgeInsets.only(top: size.height * 0.025),
                          size,
                          typeKey,
                          "type",
                        ),
                      ),
                      Form(
                        child: buildImagePickerField(
                          "image",
                          Icons.lock_outline,
                          EdgeInsets.only(top: size.height * 0.025),
                          size,
                          imageKey,
                          "image",
                        ),
                      ),
                      imageFile != null
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              height: 400.0,
                              child: ClipRect(
                                child: PhotoView(
                                  imageProvider: FileImage(
                                    File(imageFile!.path),
                                  ),
                                  maxScale:
                                      PhotoViewComputedScale.covered * 2.0,
                                  minScale:
                                      PhotoViewComputedScale.contained * 0.8,
                                  initialScale: PhotoViewComputedScale.covered,
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.015,
                            vertical: size.height * 0.025,
                          ),
                          child: CheckboxListTile(
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "By creating an account, you agree to our ",
                                    style: TextStyle(
                                      color: const Color(0xffADA4A5),
                                      fontSize: size.height * 0.015,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        // ignore: avoid_print
                                        print('Conditions of Use');
                                      },
                                      child: Text(
                                        "Conditions of Use",
                                        style: TextStyle(
                                          color: const Color(0xffADA4A5),
                                          decoration: TextDecoration.underline,
                                          fontSize: size.height * 0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                      color: const Color(0xffADA4A5),
                                      fontSize: size.height * 0.015,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        // ignore: avoid_print
                                        print('Privacy Notice');
                                      },
                                      child: Text(
                                        "Privacy Notice",
                                        style: TextStyle(
                                          color: const Color(0xffADA4A5),
                                          decoration: TextDecoration.underline,
                                          fontSize: size.height * 0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            activeColor: const Color(0xff7B6F72),
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          )),
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: ButtonWidget(
                          text: "Báo cáo",
                          backColor: isDarkMode
                              ? [
                                  Colors.black,
                                  Colors.black,
                                ]
                              : const [Color(0xff92A3FD), Color(0xff9DCEFF)],
                          textColor: const [
                            Colors.white,
                            Colors.white,
                          ],
                          onPressed: () async {
                            if (titleKey.currentState!.validate() &&
                                descriptionKey.currentState!.validate()) {
                              if (checkedValue == false) {
                                buildSnackError(
                                    'Accept our Privacy Policy and Term Of Use',
                                    context);
                              } else {
                                addReport();
                              }
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: Row(
                          //TODO: replace text logo with your logo
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: size.height * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '+',
                              style: GoogleFonts.poppins(
                                color: const Color(0xff3b22a1),
                                fontSize: size.height * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xff1D1617),
                                fontSize: size.height * 0.018,
                              ),
                            ),
                            WidgetSpan(
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: <Color>[
                                          Color(0xffEEA4CE),
                                          Color(0xffC58BF2),
                                        ],
                                      ).createShader(
                                        const Rect.fromLTWH(
                                          0.0,
                                          0.0,
                                          200.0,
                                          70.0,
                                        ),
                                      ),
                                    fontSize: size.height * 0.018,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;

  Widget buildTextField(
    String hintText,
    IconData icon,
    EdgeInsets padding,
    Size size,
    Key key,
    String stringToEdit,
  ) {
    return Padding(
      padding: padding,
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: const BoxDecoration(
          color: Color(0xffF7F8F8),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: null,
            onChanged: (value) {
              textfieldsStrings[stringToEdit] = value;
            },
            style: const TextStyle(color: Colors.black),
            textInputAction: TextInputAction.next,
            obscureText: false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(
    String hintText,
    IconData icon,
    EdgeInsets padding,
    Size size,
    Key key,
    String stringToEdit,
  ) {
    return Padding(
      padding: padding,
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: const BoxDecoration(
          color: Color(0xffF7F8F8),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: DropdownButtonFormField(
            onChanged: (String? value) {
              if (value != null) textfieldsStrings[stringToEdit] = value;
            },
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem(value: 'Hey', child: Text('Hey')),
              DropdownMenuItem(value: 'Yo', child: Text('Yo')),
            ],
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImagePickerField(
    String hintText,
    IconData icon,
    EdgeInsets padding,
    Size size,
    Key key,
    String stringToEdit,
  ) {
    return Padding(
      padding: padding,
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: const BoxDecoration(
          color: Color(0xffF7F8F8),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
            ),
            onPressed: () {
              _getFromCamera().then((value) {
                setState(() {
                  imageFile = value;
                });
              });
            },
            child:
                Text(imageFile == null ? 'Chọn từ máy ảnh' : imageFile!.name),
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, BuildContext context,
      {Size? size}) {
    size ??= MediaQuery.of(context).size;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }

  Future<XFile?> _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    return pickedFile;
  }

  Future<void> addReport() async {
    // Call the user's CollectionReference to add a new user

    String? imgUrl;
    final BuildContext ctx = context;

    if (imageFile != null) {
      try {
        await reportImageStorageRef
            .child(imageFile!.name)
            .putFile(File(imageFile!.path));
        imgUrl =
            await reportImageStorageRef.child(imageFile!.name).getDownloadURL();
      } on FirebaseException catch (e) {
        buildSnackError(e.toString(), context);
        return;
      }
    }

    try {
      await reportFirestore.add({
        'title': textfieldsStrings['title'] ?? 'Không có tiêu đề',
        'description': textfieldsStrings['description'] ?? 'Không có nội dung',
        'type': textfieldsStrings['type'] ?? 'Không phân loại',
        'image': imgUrl,
      });
      if (mounted) Navigator.pop(context);
    } on FirebaseException catch (e) {
      if (mounted) buildSnackError(e.toString(), ctx);
    }
  }
}
