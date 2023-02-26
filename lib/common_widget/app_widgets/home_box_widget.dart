import 'package:fastfill_station_app/main.dart';
import 'package:fastfill_station_app/model/station/station_with_transactions_total.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../helper/app_colors.dart';
import '../../helper/methods.dart';
import '../../helper/size_config.dart';
import '../../model/station/station.dart';
import '../../model/user/user.dart';

import '../../ui/home/new_home_tab_page.dart';
import '../../ui/home/new_home_tab_page_admin.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';
import '../buttons/custom_button.dart';
import 'custom_loading.dart';

typedef OnSetDateFilterCallBack = void Function(DateTime datetime);

class HomeBoxWidget extends StatefulWidget{

  final StationBloc stationBloc;
  final StationState stationState;
  final int totalTransactionsCount;
  final double totalTransactionsValue;
  final bool loadMore;
  final OnSetDateFilterCallBack onSetDateFilter;
  final StationWithTransactionsTotal? company;

  const HomeBoxWidget({required this.stationBloc, required this.stationState, required this.totalTransactionsCount, required this.totalTransactionsValue, required this.loadMore, required this.onSetDateFilter, this.company});

  @override
  State<HomeBoxWidget> createState() => _HomeBoxWidgetState();
}

User _buildUserInstance(AsyncSnapshot<User> snapshot) {
  if (snapshot.hasData && snapshot.data!.id != 0 && snapshot.data!.id != null)
    return snapshot.data!;
  return User();
}


class _HomeBoxWidgetState extends State<HomeBoxWidget> {

  @override
  void initState() {
    if (!notificationsController.isClosed) {
      notificationsController.stream.listen((notificationBody) {
        if (mounted) {
          hideKeyboard(context);
//      if ((notificationBody.typeId??"") == "2") {

          if (!widget.stationBloc.isClosed)
            widget.stationBloc.add(GetStationPaymentTransactionsEvent(
                true, DateTime.now(), DateTime.now(), 1));
        }
//      }
      });
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 10),
          margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home_box.png"),
                  fit: BoxFit.fill
              )
          ),
          child:
          FutureBuilder<User>(
              future: getCurrentUserValue(),
              builder: (context, AsyncSnapshot<User> snapshot) {
                User usr = _buildUserInstance(snapshot);
                if (usr.id != null) {
                  return
                    ((widget.stationState is LoadingStationState) && (!widget.loadMore)) ?
                    Container(
                        height: 200,
                        child:
                    Center(child: CustomLoading()))
                    :
                    Container(
                      child:
                      Column(children: [
                Align(child: Padding(child:
                  Text((usr.group == null) ? (usr.company != null) ? (languageCode == "en") ? usr.company!.englishName! : usr.company!.arabicName! : "" : (widget.company != null) ? (languageCode == "en") ? widget.company!.englishName! : widget.company!.arabicName! : "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: backgroundColor1, fontSize: 15)
                  )
                  ,
                      padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(50),
                      end: SizeConfig().w(50),
                      top: SizeConfig().h(40),),
                ),
                alignment: AlignmentDirectional.topStart,
                ),

                        Align(
                          child: Padding(
                            child: CustomButton(backColor: buttonColor1,
                              borderColor: Colors.white,
                              title: translate("labels.filterDate")+" : " +DateFormat("yyyy-MM-dd","en_US").format((usr.group == null) ? filterDate : adminFilterDate),
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2022, 1, 1),
                                    maxTime: DateTime(2099, 12, 31),
                                    theme: DatePickerTheme(
                                        headerColor: buttonColor1,
                                        backgroundColor: backgroundColor1,
                                        itemStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16)),
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours
                                              .toString());


                                    }, onConfirm: (date) {

                                      if (mounted) {
                                        setState(() {
                                          widget.onSetDateFilter(date);
                                        });
                                      }

                                      _updateFilters(usr);

                                    },
                                    currentTime: (usr.group == null) ? filterDate : adminFilterDate,
                                    locale: (isArabic()) ? LocaleType.ar : LocaleType.en);
                              },
                            ),
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig().w(50),
                                end: SizeConfig().w(50),
                                top: SizeConfig().h(20),),
                          ),
                          alignment: AlignmentDirectional.topStart,
                        ),
                        Align(
                          child: Padding(
                            child: Text(
                              translate("labels.totalTransactionsCount") +
                                  " : " +
                                  widget.totalTransactionsCount.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: backgroundColor1, fontSize: 15),
                            ),
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig().w(25),
                                end: SizeConfig().w(25),
                                top: SizeConfig().h(20)),
                          ),
                          alignment: AlignmentDirectional.topStart,
                        ),
                        Align(
                          child: Padding(
                            child: Text(
                              translate("labels.totalTransactionsValue") +
                                  " : " +
                                  formatter.format(widget.totalTransactionsValue) + " "+translate("labels.sdg"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: backgroundColor1,
                                  fontSize: 15),
                            ),
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig().w(25),
                                end: SizeConfig().w(25),
                                bottom: SizeConfig().w(35),
                                top: SizeConfig().h(10)),
                          ),
                          alignment: AlignmentDirectional.topStart,
                        ),
                      ],)
                  );
                } else {
                  return CustomLoading();
                }
              })
      );
  }

  _updateFilters(User usr)
  {
    if (!widget.stationBloc.isClosed) {
      if (widget.company != null)
        widget.stationBloc.add(
            GetStationPaymentTransactionsEventByCompanyId(true, (usr.group == null) ? filterDate : adminFilterDate, (usr.group == null) ? filterDate : adminFilterDate, 1, widget.company!.id!));
      else
        widget.stationBloc.add(
            GetStationPaymentTransactionsEvent(true, (usr.group == null) ? filterDate : adminFilterDate, (usr.group == null) ? filterDate : adminFilterDate, 1));
    }
  }
}


