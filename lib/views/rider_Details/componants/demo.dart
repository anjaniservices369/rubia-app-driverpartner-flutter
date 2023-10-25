import 'package:base_project_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:sizer/sizer.dart';

class MultiselectDroupdown extends StatefulWidget {
  @override
  _MultiselectDroupdownState createState() => _MultiselectDroupdownState();
}

class _MultiselectDroupdownState extends State<MultiselectDroupdown> {
  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: MultiSelectFormField(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: tPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                autovalidate: AutovalidateMode.disabled,
                chipBackGroundColor: Colors.transparent,
                chipLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: tSecondaryColor),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                // checkBoxActiveColor: Colors.blue,
                // checkBoxCheckColor: Colors.white,

                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),

                title: Text(
                  "Please select one or more options",
                  style: TextStyle(fontSize: 16, color: tSecondaryColor),
                ),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Please select one or e options';
                  }
                  return null;
                },
                dataSource: [
                  {
                    "display": "Running",
                    "value": "Running",
                  },
                  {
                    "display": "Climbing",
                    "value": "Climbing",
                  },
                  {
                    "display": "Walking",
                    "value": "Walking",
                  },
                  {
                    "display": "Swimming",
                    "value": "Swimming",
                  },
                  {
                    "display": "Soccer Practice",
                    "value": "Soccer Practice",
                  },
                  {
                    "display": "Baseball Practice",
                    "value": "Baseball Practice",
                  },
                  {
                    "display": "Football Practice",
                    "value": "Football Practice",
                  },
                ],
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                hintWidget: Text('Please choose one or more'),
                initialValue: _myActivities,
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _myActivities = value;
                  });
                },
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: ElevatedButton(
            //     child: Text('Save'),
            //     onPressed: _saveForm,
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(16),
            //   child: Text(_myActivitiesResult),
            // )
          ],
        ),
      ),
    );
  }
}
