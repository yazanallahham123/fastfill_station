import 'package:fastfill_station_app/ui/home/new_transactions_tab_page_admin.dart';
import 'package:fastfill_station_app/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common_widget/custom_app_bar/home_appbar_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../main.dart';
import '../../model/user/user.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';
import 'new_home_tab_page.dart';
import 'new_home_tab_page_admin.dart';
import 'new_notifications_tab_page.dart';
import 'new_transactions_tab_page.dart';


class HomePage extends StatefulWidget {
  static const route = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int pageIndex = 0;

  final pages = [
    (currentUser != null) ? (currentUser!.group != null) ? const NewHomeTabAdminPage() : const NewHomeTabPage() : const NewHomeTabPage(),
    (currentUser != null) ? (currentUser!.group != null) ? const NewTransactionsTabAdminPage() : const NewTransactionsTabPage():const NewTransactionsTabPage(),
    const NewNotificationsTabPage(),
  ];

  @override
  void initState() {

    notificationsController.stream.listen((notificationBody) {

      /*if ((notificationBody.typeId??"") == "2") {
        hideKeyboard(context);
        StationPaymentResultBody prb = StationPaymentResultBody(
            date: DateFormat('yyyy-MM-dd - hh:mm a').format(
                DateTime.parse(notificationBody.date!)),
            userName: notificationBody.userName!,
            mobileNumber: notificationBody.userMobileNo!,
            fuelTypeId: int.parse(notificationBody.material!),
            amount: double.parse(notificationBody.price!),
            value: double.parse(notificationBody.fastFill!),
            status: true,
            fromList: true);
        Navigator.pushNamed(
            context, StationPaymentResultPage.route, arguments: prb);
      }*/
    });


    super.initState();
  }

  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor1,
      bottomNavigationBar: Container(
        height: 62,
        decoration: BoxDecoration(
          color: backgroundColor2,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 0;
                  homePageIndex = 0;
                  downloadMode = false;
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(25, 5, 10, 15),
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(45),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/homebutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 0) ? activeTabColor : notActiveTabColor,
                  )),
            ), flex: 1,),


            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 1;
                  homePageIndex = 1;
                  downloadMode = false;
                });
              },
              child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                  //alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                  ),

                  height: SizeConfig().h(55),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/transactionsbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 1) ? activeTabColor : notActiveTabColor,
                  )),
            ),flex: 1,),

            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 2;
                  homePageIndex = 2;
                  downloadMode = false;
                });
              },
              child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                //alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                  ),

                  height: SizeConfig().h(55),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/notificationsbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 2) ? activeTabColor : notActiveTabColor,
                  )),
            ),flex: 1,),

          ],
        ),
      ),

      appBar: new HomeAppBarWidget(),
      body: pages[pageIndex]
    );
  }
}

