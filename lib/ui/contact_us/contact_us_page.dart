import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widget/app_widgets/back_button_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../utils/misc.dart';


class ContactUsPage extends StatefulWidget {
  static const route = "/contactus_page";
  static const whatsappNumber = "+249111200690";

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor1 ,
      body: SafeArea(child:
      SingleChildScrollView(
          child:
          Stack(
            children: [
              Padding(padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(120), 0, 0),child:
              Column(children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.contactUs"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                      )),
                  alignment: AlignmentDirectional.topStart,
                ),

                Padding(child: Align(child: Text(translate("labels.weAreInTouch"),
                    style: TextStyle(color: textColor2)
                ),
                  alignment: AlignmentDirectional.topStart,),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(30), bottom: SizeConfig().h(30)),
                ),

                Align(
                  child: Padding(
                      child:  Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage("assets/logo.png")),),
                      ),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          bottom: SizeConfig().h(25)
                      )),
                  alignment: AlignmentDirectional.topCenter,
                ),
                Align(child: Text(_packageInfo.buildNumber, style: TextStyle(color: Colors.white),),alignment: AlignmentDirectional.topCenter,),


                Padding(child:
                InkWell(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        "assets/svg/email_icon.svg", width: 20, height: 20,),
                      Padding(child: Text(translate("labels.email"), style: TextStyle(fontSize: 10, color: textColor2),), padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),)
                    ],),
                    Padding(child: Text("fastffillsudan@gmail.com", style: TextStyle(color: Colors.white),), padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),)
                    ,Divider(color: textColor2, thickness: 0.1,)
                  ],),onTap: () { openEmail("fastffillsudan@gmail.com"); },), padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(10),
                    SizeConfig().w(25), SizeConfig().h(10)),),


                Padding(child:
                InkWell(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        "assets/svg/whatsapp_icon.svg", width: 20, height: 20,),
                      Padding(child: Text(translate("labels.whatsapp"), style: TextStyle(fontSize: 10, color: textColor2),), padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),)
                    ],),
                    Padding(child:

                    Text("+249111200690", style: TextStyle(color: Colors.white),),
                      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),)
                    ,Divider(color: textColor2, thickness: 0.1,)
                  ],),
                  onTap: (){
                    hideKeyboard(context);
                    openWhatsapp(context, ContactUsPage.whatsappNumber);

                  },),
                    padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(10),
                        SizeConfig().w(25), SizeConfig().h(10))
                ),

              ])),
              BackButtonWidget(context)
            ],)
      )),
    );
  }

  openEmail(String email) async
  {
    await launchUrl(Uri.parse("mailto:<"+email+">?subject=<>&body=<>"));
  }

  callNumber(String number) async {
    await launchUrl(Uri.parse("tel://"+number));
  }

  openWhatsapp(BuildContext context, String whatsappNumber) async{
    var whatsappURl_android = "whatsapp://send?phone="+whatsappNumber+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsappNumber?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only

      if( await canLaunchUrl(Uri.parse(whatappURL_ios))){
        await launchUrl(Uri.parse(whatappURL_ios));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }else{
      // android , web
      if( await canLaunchUrl(Uri.parse(whatsappURl_android))){
        await launchUrl(Uri.parse(whatsappURl_android));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }
  }
}
