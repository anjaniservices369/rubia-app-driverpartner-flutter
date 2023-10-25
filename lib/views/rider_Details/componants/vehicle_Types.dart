import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/rider_details/add_Details.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../responsive.dart';

import 'documents/documents.dart';

class VechileSelection extends StatefulWidget {
  const VechileSelection({Key? key}) : super(key: key);

  @override
  State<VechileSelection> createState() => _VechileSelectionState();
}

class _VechileSelectionState extends State<VechileSelection> {
  @override
  void initState() {
    getVechileList('');
    // TODO: implement initState
    super.initState();
  }

  var entityValue = 'Vehicles you can drive';
  bool isdropdownOpwn = false;
  List _entityList = [
    'Car',
    'Loader',
    'trauck',
  ];
  List<String> improveList = [
    'Fast Delivey',
    'Customer support',
    'Speed and efficiency',
    'Overall Service',
  ];

  List<String>? selectedimprove = [];
  var vechileDetails;
  var resNok;

  bool iseckbox = true;
  bool icheckbox = true;
  List<String> vechileId = [];
  List<String> vechileName = [];

  List<String> vechilListselectedItems = [];
  List<String> vechilListSelectedId = [];
  List<String> vechileTitle = [];
  List<String> vechileListId = [];
  List<String> vechileNewList = [];
  List<String> vechileNewListId = [];
  var selectedlangId;
  var langId;
  var langTitle;
  var responce;
  var resNOK;
  var mylanguageList;

  getVechileList(String type) async {
    responce = await DriverDetailsApi().getDriverVehicleTypes(context, type);
    if (responce != null && responce['status'] == 'OK') {
      for (var i = 0; i <= responce['details'].length - 1; i++) {
        vechileTitle.add(responce['details'][i]['title']);
        vechileListId.add(responce['details'][i]['id'].toString());
        print('vechileTitle');
        print(vechileTitle);
        print('vechileListId..>');
        print(vechileListId);
      }
      setState(() {
        mylanguageList = responce['details'];
        print(mylanguageList);
        debugPrint('print(fetechMyStore);: $print(fetechMyStore);');
      });
    } else {
      setState(() {
        resNOK = responce['status'];
        print(resNOK);
      });
    }
  }

  var selectedIndex;

  int vechileRadioValue = 2;
  int vechileRadioValueType = 2;
  int vechileRadioValueSpeed = 1;
  String radioButtonItem = 'Non-electric';
  String radioVechileSpeed = 'Low speed';
  String radioVechileType = 'Own';
  var vehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.forceNavigateTo(context, AddDetailsView());
          },
        ),
        centerTitle: false,
        title: Text('vehicle_types'.tr,
            style: TextStyle(
                // fontFamily: 'Plus Jakarta Sans',
                fontSize: isTab(context) ? 12.sp : 14.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, AddDetailsView());
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.6.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 36.w),
                        child: StepProgressIndicator(
                          totalSteps: 4,
                          currentStep: 2,
                          size: 8,
                          padding: 0,
                          selectedColor: tSecondaryColor,
                          unselectedColor: tlightGray,
                          roundedEdges: Radius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'vehicle_gear_type'.tr,
                              style: TextStyle(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context) ? 9.sp : 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 1.3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: tPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            side: BorderSide(
                                                color: icheckbox == true
                                                    ? tPrimaryColor
                                                    : tPrimaryColor,
                                                width: 0.6)),
                                        value: icheckbox,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            icheckbox = value!;
                                            print(icheckbox);
                                          });
                                          if (icheckbox == true) {
                                            setState(() {
                                              vechileTitle.clear();
                                              vechileListId.clear();
                                              getVechileList(
                                                  vehicle_types_manual
                                                      .toString());
                                            });
                                            // if (iseckbox == true) {
                                            //   setState(() {
                                            //     vechileTitle.clear();
                                            //     vechileListId.clear();
                                            //     getVechileList('');
                                            //   });
                                            // }
                                          } else {
                                            print('im here');
                                            setState(() {
                                              vechileTitle.clear();
                                              vechileListId.clear();
                                              iseckbox = true;
                                            });
                                            getVechileList(
                                                vehicle_types_automatic
                                                    .toString());
                                          }
                                        }),
                                    Container(
                                      width: 25.w,
                                      child: Text(
                                        'manual'.tr,
                                        style: TextStyle(
                                          color: tSecondaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 9.sp : 12.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1,
                                      child: Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: tPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: BorderSide(
                                                  color: iseckbox == true
                                                      ? tPrimaryColor
                                                      : tPrimaryColor,
                                                  width: 0.6)),
                                          value: iseckbox,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              iseckbox = value!;
                                              print(iseckbox);
                                            });
                                            if (iseckbox == true) {
                                              setState(() {
                                                vechileTitle.clear();
                                                vechileListId.clear();
                                                getVechileList(
                                                    vehicle_types_automatic
                                                        .toString());
                                              });
                                              // if (icheckbox == true) {
                                              //   setState(() {
                                              //     vechileTitle.clear();
                                              //     vechileListId.clear();
                                              //     getVechileList('');
                                              //   });
                                              // }
                                            } else {
                                              print('im here too');
                                              setState(() {
                                                vechileTitle.clear();
                                                vechileListId.clear();
                                                icheckbox = true;
                                              });
                                              getVechileList(
                                                  vehicle_types_manual
                                                      .toString());
                                            }
                                          }),
                                    ),
                                    Container(
                                      width: 25.w,
                                      child: Text(
                                        'automatic'.tr,
                                        style: new TextStyle(
                                          color: tSecondaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 9.sp : 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.3.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: tBlue)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                'Select Items',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: tBlue,
                                ),
                              ),
                            ),
                            customButton: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: tBackground,
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Text(langTitle == null ? '' : langTitle),
                                  Container(
                                    width: 70.w,
                                    child: Text(
                                      vechileNewList.isEmpty
                                          ? 'Select vechile type'
                                          : vechileNewList
                                              .join(', ')
                                              .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: tBlue, fontSize: 14.sp),
                                    ),
                                  ),
                                  // Spacer(),
                                  Icon(
                                      // isdropdownOpwn
                                      //     ?
                                      Icons.keyboard_arrow_up
                                      // : Icons.keyboard_arrow_down,
                                      )
                                ],
                              ),
                            ),
                            items: vechileListId.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                //disable default onTap to avoid closing menu when selecting an item
                                enabled: false,
                                child: StatefulBuilder(
                                  builder: (context, menuSetState) {
                                    final _isSelected =
                                        vechilListselectedItems.contains(item);
                                    return InkWell(
                                      onTap: () async {
                                        if (icheckbox == true ||
                                            iseckbox == true) {
                                          setState(() {
                                            langTitle = vechileTitle[
                                                vechileListId.indexOf(item)];
                                            if (vechileNewList.contains(
                                                vechileTitle[vechileListId
                                                    .indexOf(item)])) {
                                              vechileNewList.removeAt(
                                                  vechileNewList.indexOf(
                                                      vechileTitle[vechileListId
                                                          .indexOf(item)]));
                                              vechileNewListId.remove(
                                                  vechileListId[vechileListId
                                                      .indexOf(item)]);
                                            } else {
                                              vechileNewList.add(vechileTitle[
                                                  vechileListId.indexOf(item)]);
                                              vechileNewListId.add(
                                                  vechileListId[vechileListId
                                                      .indexOf(item)]);
                                            }

                                            print("vechileNewList");
                                            print(vechileNewList);
                                            print(vechileNewListId);
                                            print("vechileNewList");
                                          });
                                          _isSelected
                                              ? vechilListselectedItems
                                                  .remove(item)
                                              : vechilListselectedItems
                                                  .add(item);
                                          setState(() {
                                            selectedlangId = vechileListId[
                                                vechileListId.indexOf(item)];
                                            print('object:' +
                                                selectedlangId.toString());
                                          });

                                          menuSetState(() {});
                                        } else {
                                          Twl.createAlert(context, 'Oopss',
                                              'Please select vehicle type');
                                        }
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            _isSelected
                                                ? Icon(
                                                    Icons.check_box_outlined,
                                                    color: tPrimaryColor,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    color: tGray,
                                                  ),
                                            const SizedBox(width: 16),
                                            Text(
                                              vechileTitle[
                                                  vechileListId.indexOf(item)],
                                              style: const TextStyle(
                                                  fontSize: 14, color: tBlue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),

                            value: vechilListselectedItems.isEmpty
                                ? null
                                : vechilListselectedItems.last,
                            onChanged: (value) {},
                            // buttonHeight: 40,
                            // buttonWidth: 140,
                            selectedItemBuilder: (context) {
                              return vechileTitle.map(
                                (item) {
                                  return Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      vechilListselectedItems.join(', ') +
                                          vechileListId.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 2.h,
                      ),

                      // : Container(),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Button(
              textcolor: tWhite,
              bottonText: 'Next'.tr,
              borderSide: BorderSide(
                color: tPrimaryColor,
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                startLoading();
                // Twl.forceNavigateTo(context, Documents());
                if (vechileNewList != null) {
                  Map<String, String> param = {
                    'vehicle_type_id': vechileNewListId
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', ''),
                  };
                  print(param);
                  var res =
                      await DriverDetailsApi().addVehicleType(context, param);
                  if (res != null && res['status'] == 'OK') {
                    Twl.forceNavigateTo(context, AddDetailsView());
                  } else {
                    stopLoading();
                    Twl.createAlert(context, 'Oops', res['error'].toString());
                    stopLoading();
                  }
                  stopLoading();
                } else {
                  Twl.createAlert(
                      context, 'Oops', 'Please select your vehicle');
                }
                stopLoading();
              },
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
