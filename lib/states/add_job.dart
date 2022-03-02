import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_form.dart';
import 'package:officesv/widgets/show_image.dart';
import 'package:officesv/widgets/show_text.dart';

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
  String? chooseAgree, addDate;

  var iTemChooses = <bool>[false, false, false];

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
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  Container newAddDate() {
    DateTime dateTime = DateTime.now();

    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    addDate = dateFormat.format(dateTime);

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
                  onPressed: () {},
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
        changeFunc: (String string) {});
  }

  Showform newJob() {
    return Showform(
        label: 'Job', icondata: Icons.work, changeFunc: (String string) {});
  }

  SizedBox newImage() {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        children: [
          ShowImage(
            path: 'images/picture.png',
          ),
          Positioned(
            bottom: 8,
            right: 0,
            child: IconButton(
                onPressed: () {},
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
}
