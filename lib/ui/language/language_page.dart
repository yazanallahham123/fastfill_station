
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

import '../../bloc/login/bloc.dart';
import '../../bloc/login/state.dart';
import '../../bloc/user/bloc.dart';
import '../../bloc/user/event.dart';
import '../../bloc/user/state.dart';
import '../../common_widget/app_widgets/back_button_widget.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/buttons/custom_button.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../auth/login_page.dart';
import '../home/home_page.dart';

class LanguagePage extends StatefulWidget {
  static const route = "/language_page";

  final bool forSettings;

  const LanguagePage({required this.forSettings});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

bool loading = false;

class _LanguagePageState extends State<LanguagePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is ErrorUserState)
          {
            if (mounted) {
              setState(() {
                loading = true;
              });
            }
          }
          else if (state is UpdatedUserLanguageState) {
            Navigator.pop(context, languageCode);
          }
        },
        bloc: bloc,
        child: BlocBuilder<UserBloc, UserState>(
            bloc: bloc,
            builder: (context, UserState state) {
              return _BuildUI(bloc: bloc, state: state, forSettings: widget.forSettings);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc bloc;
  final UserState state;
  final bool forSettings;

  _BuildUI({required this.bloc, required this.state, required this.forSettings});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  String? currentLanguage = (languageCode == "en") ? "English" : "عربي";

  void initState() {
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        SafeArea(child:
        SingleChildScrollView(
          child: Stack(children: [

            Column(children: [

              Align(
                child: Padding(
                    child:  Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/logo.png")),),
                    ),
                    padding: EdgeInsetsDirectional.only(
                        top: SizeConfig().h(100),
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                        bottom: SizeConfig().h(25)
                    )),
                alignment: AlignmentDirectional.topCenter,
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsetsDirectional.only(
                    top: SizeConfig().h(25),
                    start: SizeConfig().w(20),
                    end: SizeConfig().w(20)),
                padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                decoration:
                BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                child:
                (loading == false) ?

                Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    Padding(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Language", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("اللغة",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],), padding: EdgeInsetsDirectional.fromSTEB(0,20, 0, 0),),

                    Padding(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5, end: 5, top: SizeConfig().h(10), bottom:  SizeConfig().h(40)),
                            child: CustomButton(
                                backColor: buttonColor1,
                                titleColor: Colors.white,
                                borderColor: buttonColor1,
                                title: "English",
                                onTap: () async {
                                  if (mounted) {
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  hideKeyboard(context);

                                  currentLanguage = "English";
                                  await setLanguageValue("en");
                                  languageCode = "en";
                                  FastFillStationApp.setLocale(context, Locale.fromSubtags(languageCode: "en"));
                                  changeLocale(context, "en");
                                  Get.updateLocale(Locale.fromSubtags(languageCode: "en"));

                                  languageId = 1;


                                  if (!widget.forSettings) {
                                    Navigator.pushNamed(context, LoginPage.route);
                                  }
                                  else
                                    widget.bloc.add(UpdateUserLanguageEvent(languageId));
                                })), flex: 1,),
                        Expanded(child: Padding(
                            padding: EdgeInsetsDirectional.only( start: 5, end: 5, top: SizeConfig().h(10), bottom:  SizeConfig().h(40)),
                            child: CustomButton(
                                backColor: buttonColor1,
                                titleColor: Colors.white,
                                borderColor: buttonColor1,
                                title: "عربي",
                                onTap: () async {
                                  if (mounted) {
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  hideKeyboard(context);
                                  currentLanguage = "عربي";
                                  await setLanguageValue("ar");
                                  languageCode = "ar";
                                  FastFillStationApp.setLocale(context, Locale.fromSubtags(languageCode: "ar"));
                                  changeLocale(context, "ar");
                                  Get.updateLocale(Locale.fromSubtags(languageCode: "ar"));

                                  languageId = 2;

                                  if (!widget.forSettings) {
                                    Navigator.pushNamed(context, LoginPage.route);
                                  }
                                  else
                                    widget.bloc.add(UpdateUserLanguageEvent(languageId));
                                })),flex: 1,),
                      ],), padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),),

                  ],
                ) :
                Container(
                    height: SizeConfig().h(250),
                    child:
                    Center(child: CustomLoading()))
                ,
              )

            ],),

            (widget.forSettings) ? BackButtonWidget(context) : Container()],),
        ))

    );
  }
}
