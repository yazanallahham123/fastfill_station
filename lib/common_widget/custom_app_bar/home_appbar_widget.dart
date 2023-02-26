
import 'package:fastfill_station_app/common_widget/buttons/custom_button.dart';
import 'package:fastfill_station_app/helper/const_styles.dart';
import 'package:fastfill_station_app/streams/download_mode_stream.dart';
import 'package:fastfill_station_app/ui/contact_us/contact_us_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/user/bloc.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../main.dart';
import '../../ui/auth/login_page.dart';
import '../../ui/profile/profile_page.dart';
import '../../ui/settings/settings_page.dart';
import '../../utils/misc.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, systemNavigationBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: backgroundColor1,
        title:
   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          PopupMenuButton(
              onSelected: (s) async {
                hideKeyboard(context);
                if (s == LoginPage.route)
                  {
                    showLogoutAlertDialog(context);
                  }
                else if (s == SettingsPage.route)
                {
                  Navigator.pushNamed(context, SettingsPage.route);
                }
                else if (s == ContactUsPage.route)
                  {
                    Navigator.pushNamed(context, ContactUsPage.route);
                  }
              },
              color: backgroundColor1,
                itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: SettingsPage.route,
                      child: Text(translate("labels.settings"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: ContactUsPage.route,
                      child: Text(translate("labels.contactUs"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: LoginPage.route,
                      child: Text(translate("labels.logout"), style: TextStyle(color: Colors.white),),
                    )
                  ],
            child: Container(
                alignment: Alignment.topLeft,
                height: SizeConfig().h(45),
                width: SizeConfig().h(45),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig().w(12),
                    vertical: SizeConfig().h(55)),
                child: SvgPicture.asset(
                  'assets/svg/menu.svg',
                  width: SizeConfig().w(50),
                ))),

          (currentUser!.group == null)
          ?
          (homePageIndex == 0 || homePageIndex == 1) ?

          Padding(child: InkWell(
              onTap: () async {
                downloadMode = !downloadMode;
                updateDownloadModeStreamController.sink.add(downloadMode);
              },
              child:
              Container(
                  decoration: BoxDecoration(
                      color: backgroundColor4, borderRadius: radiusAll10),
                  padding: EdgeInsets.all(8),
                  child:
                  Row(children: [
                    Padding(child:
                    Image(image: AssetImage("assets/download_icon.png"),
                        width: 25, height: 25
                    ), padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),),

                    Text(
                      translate("buttons.download"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: buttonColor1),
                    ),
                  ],))
          ), padding: EdgeInsetsDirectional.fromSTEB(0, 37, 0, 30),) : Container()
          :Container(),

          Padding(child: InkWell(
            onTap: () async {
              hideKeyboard(context);
              Navigator.pushNamed(context, ProfilePage.route);
            },
            child: Container(
                alignment: Alignment.topRight,
                height: SizeConfig().h(45),
                width: SizeConfig().h(45),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig().w(12),
                    vertical: SizeConfig().h(55)),
                child: SvgPicture.asset(
                  'assets/svg/profile.svg',
                  width: SizeConfig().w(50),
                )),
          ), padding: EdgeInsetsDirectional.fromSTEB(0, 37, 0, 30),)
      ],),

    );
  }
}
