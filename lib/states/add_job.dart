import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/utility/my_dialog.dart';
import 'package:officesv/widgets/show_button.dart';
import 'package:officesv/widgets/show_form.dart';
import 'package:officesv/widgets/show_image.dart';
import 'package:officesv/widgets/show_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJob extends StatefulWidget {
  const AddJob({
    Key? key,
  }) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  var factorKeys = <int>[1, 2, 3, 4];

  int? chooseFactoryKey;
  String? chooseAgree, addDate, jobName, detailJob, userLogin;

  var iTemChooses = <bool>[false, false, false];

  DateTime? dateTime;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  File? file;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
    setState(() {
      addDate = dateFormat.format(dateTime!);
    });

    findUser();
  }

  Future<void> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = preferences.getStringList('data');
    userLogin = result![2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Add Job'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  newImage(),
                  newJob(),
                  newDetail(),
                  newFactoryKey(),
                  displayCalculate(),
                  newAgree(),
                  chooseItem(),
                  newAddDate(),
                  newJobButton(),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  ShowButton newJobButton() => ShowButton(
      label: 'Add Job to Server',
      pressFunc: () {
        if (file == null) {
          MyDialog(context: context)
              .normalDialog('No picture?', 'Please Take Photo');
        } else if ((jobName?.isEmpty ?? true) || (detailJob?.isEmpty ?? true)) {
          MyDialog(context: context)
              .normalDialog('Have Space', 'Please Fill Job and Detail');
        } else if (chooseFactoryKey == null) {
          MyDialog(context: context)
              .normalDialog('No FactoryKey', 'Please Choose Factory Key');
        } else if (chooseAgree == null) {
          MyDialog(context: context)
              .normalDialog('No Agree', 'Please Choose Yes or No');
        } else if (checkChooseItem()) {
          MyDialog(context: context)
              .normalDialog('No Item', 'Please Choose Item');
        } else {
          processUploadAndInsert();
        }
      });

  Container newAddDate() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 50),
      padding: EdgeInsets.all(16),
      decoration: MyConstant().curBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowText(
            label: 'Add Date :',
            textStyle: MyConstant().h2Style(),
          ),
          SizedBox(
            width: 250,
            child: ListTile(
              title: ShowText(label: addDate ?? 'dd / MM / yyyy'),
              trailing: IconButton(
                  onPressed: () async {
                    DateTime? chooseDateTime = await showDatePicker(
                        context: context,
                        initialDate: dateTime!,
                        firstDate: DateTime(dateTime!.year - 1),
                        lastDate: DateTime(dateTime!.year + 1));

                    if (chooseDateTime != null) {
                      setState(() {
                        addDate = dateFormat.format(chooseDateTime);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    size: 36,
                    color: MyConstant.dark,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container chooseItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: MyConstant().curBorder(),
      child: Column(
        children: [
          SizedBox(
            width: 250,
            child: ShowText(
              label: 'Item :',
              textStyle: MyConstant().h2Style(),
            ),
          ),
          newCheckBox(index: 0, label: 'Doramon'),
          newCheckBox(index: 1, label: 'Nobita'),
          newCheckBox(index: 2, label: 'Sunako'),
        ],
      ),
    );
  }

  SizedBox newCheckBox({required int index, required String label}) {
    return SizedBox(
      width: 250,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: ShowText(label: label),
        value: iTemChooses[index],
        onChanged: (value) {
          setState(() {
            iTemChooses[index] = value!;
          });
        },
      ),
    );
  }

  Container newAgree() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(16),
      decoration: MyConstant().curBorder(),
      child: Column(
        children: [
          SizedBox(
            width: 250,
            child: ShowText(
              label: 'Agree :',
              textStyle: MyConstant().h2Style(),
            ),
          ),
          Container(
            width: 250,
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: RadioListTile(
                    title: const ShowText(label: 'Yes'),
                    value: 'yes',
                    groupValue: chooseAgree,
                    onChanged: (value) {
                      setState(() {
                        chooseAgree = value.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: RadioListTile(
                    title: const ShowText(label: 'No'),
                    value: 'no',
                    groupValue: chooseAgree,
                    onChanged: (value) {
                      setState(() {
                        chooseAgree = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayCalculate() {
    return chooseFactoryKey == null
        ? const SizedBox()
        : Container(
            alignment: Alignment.center,
            width: 250,
            height: 40,
            decoration: MyConstant().curBorder(),
            child: ShowText(
                label: '$chooseFactoryKey x 500 = ${chooseFactoryKey! * 500}'),
          );
  }

  Container newFactoryKey() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: 250,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: MyConstant().curBorder(),
      child: DropdownButton<dynamic>(
          hint: Row(
            children: [
              Icon(
                Icons.android,
                color: MyConstant.dark,
              ),
              const SizedBox(
                  child: const ShowText(label: 'Please Choose Factory')),
            ],
          ),
          value: chooseFactoryKey,
          items: factorKeys
              .map(
                (e) => DropdownMenuItem(
                  child: ShowText(label: 'factory Key => $e'),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              chooseFactoryKey = value;
            });
            print('chooseFactory ==> $chooseFactoryKey');
          }),
    );
  }

  Showform newDetail() {
    return Showform(
        label: 'Detail',
        icondata: Icons.details,
        changeFunc: (String string) {
          detailJob = string.trim();
        });
  }

  Showform newJob() {
    return Showform(
        label: 'Job',
        icondata: Icons.work,
        changeFunc: (String string) {
          jobName = string.trim();
        });
  }

  SizedBox newImage() {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        children: [
          file == null
              ? const ShowImage(
                  path: 'images/picture.png',
                )
              : Image.file(
                  file!,
                  fit: BoxFit.cover,
                ),
          Positioned(
            bottom: 8,
            right: 0,
            child: IconButton(
                onPressed: () {
                  chooseImageDialog();
                },
                icon: Icon(
                  Icons.add_a_photo,
                  size: 48,
                  color: MyConstant.dark,
                )),
          ),
        ],
      ),
    );
  }

  Future<void> chooseImageDialog() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: ListTile(
                leading: ShowImage(
                  path: 'images/picture.png',
                ),
                title: ShowText(
                  label: 'กรุณาเลือกรูปภาพ',
                  textStyle: MyConstant().h2Style(),
                ),
                subtitle:
                    const ShowText(label: 'โดยการคลิ๊ก Camera หรือ Gallery'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      processTakePhoto(imageSource: ImageSource.camera);
                    },
                    child: const Text('Camera')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      processTakePhoto(imageSource: ImageSource.gallery);
                    },
                    child: const Text('Gallery')),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
              ],
            ));
  }

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );

    setState(() {
      file = File(result!.path);
    });
  }

  bool checkChooseItem() {
    bool result = true;

    for (var item in iTemChooses) {
      if (item) {
        result = false;
      }
    }

    return result;
  }

  Future<void> processUploadAndInsert() async {
    String pathUpload = 'https://www.androidthai.in.th/sv/saveFilekaran.php';
    int code = Random().nextInt(1000000);
    String nameFile = 'job$code.jpg';
    print('nameFile ==> $nameFile');

    Map<String, dynamic> map = {};
    map['file'] = await MultipartFile.fromFile(file!.path, filename: nameFile);
    FormData formData = FormData.fromMap(map);
    await Dio().post(pathUpload, data: formData).then((value)  async {
      String pathImage = 'https://www.androidthai.in.th/sv/pickaran/$nameFile';

      print('pathImage  = $pathImage');

      String qrCode = 'code$code';

      String pathInsert =
          'https://www.androidthai.in.th/sv/insertJobKaran.php?isAdd=true&nameRecord=$userLogin&jobName=$jobName&detailJob=$detailJob&factoryKey=$chooseFactoryKey&agree=$chooseAgree&item=${iTemChooses.toString()}&addDate=$addDate&qRcode=$qrCode&pathImage=$pathImage';

          await Dio().get(pathInsert).then((value) => Navigator.pop(context));
    });
  }
}
