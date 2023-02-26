
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/user/bloc.dart';
import '../../bloc/user/event.dart';
import '../../bloc/user/state.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/app_widgets/normal_notification_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/notification/notification_body.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';

class NewNotificationsTabPage extends StatefulWidget {
  const NewNotificationsTabPage({Key? key}) : super(key: key);

  @override
  State<NewNotificationsTabPage> createState() => _NewNotificationsTabPageState();
}

List<NotificationBody> notifications = [];
bool hasNext = false;
int currentPage = 1;
bool loadMore = false;

class _NewNotificationsTabPageState extends State<NewNotificationsTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc()..add(UserInitEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is InitUserState) {
            notifications = [];
            currentPage = 1;
            loadMore = false;
            bloc.add(GetNotificationsEvent(1));
          }
          else
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is GotNotificationsState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.notifications.paginationInfo != null)
                    hasNext = state.notifications.paginationInfo!.hasNext!;
                  else
                    hasNext = false;

                  if (state.notifications.notifications != null)
                    notifications.addAll(state.notifications.notifications!.where((n) => ((n.typeId != "3") && (n.typeId != "4") && (n.typeId != "2"))));
                  else {
                    hasNext = false;
                  }


                print("Current Page:");
                print(currentPage);
                print("hasNext:");
                print(hasNext);
              });
            }
          }
          else
          if (state is ClearedUserNotificationsState)
          {
            if (mounted) {
              setState(() {
                currentPage = 1;
                loadMore = false;
                notifications = [];
              });
            }
          }

        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, UserState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc bloc;
  final UserState state;


  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {

  ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);

    if (!notificationsController.isClosed) {
      notificationsController.stream.listen((notificationBody) {
        if (mounted) {
          hideKeyboard(context);
          notifications = [];
          currentPage = 1;
          loadMore = false;
          if (!widget.bloc.isClosed)
            widget.bloc.add(GetNotificationsEvent(1));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        Column(children: [
          Align(
            child: Padding(
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate("labels.notifications"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: buttonColor1),
                    ),
                    (notifications.length > 0) ?

                    InkWell(child:
                    Text(translate("buttons.clear"),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: buttonColor1)), onTap: () {
                      if (!widget.bloc.isClosed) {
                        widget.bloc.add(ClearUserNotificationsEvent());
                      }
                    },) :

                    Container()
                  ],),
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig().w(25),
                    end: SizeConfig().w(25),
                    top: SizeConfig().h(10))),
            alignment: AlignmentDirectional.topStart,
          ),
          Expanded(child:
          ((widget.state is InitUserState) || ((widget.state is LoadingUserState) && (!loadMore))) ? Center(child:
          CustomLoading(),) :

          LayoutBuilder(builder: (context, constraints) =>
              RefreshIndicator(onRefresh: () async {
                currentPage = 1;
                notifications = [];
                loadMore = false;
                hasNext = false;
                if (!widget.bloc.isClosed)
                  widget.bloc.add(GetNotificationsEvent(1));
              },
                  color: Colors.white,
                  backgroundColor: buttonColor1,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child:


                  (notifications.length == 0) ?
                  SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child:
                      ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child:

                          Center(child: ListView(
                            shrinkWrap: true,
                            children: [

                              Align(child: SvgPicture.asset("assets/svg/no_notifications.svg"),alignment: AlignmentDirectional.center,),
                              Align(child: Text(translate("labels.noNotifications"), style: TextStyle(color: Colors.white),),alignment: AlignmentDirectional.center,)

                            ],

                          )))) :
    Stack(children: [
                  ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    itemBuilder: (context, index)
                    {
                      return Padding(child: NormalNotificationWidget(notification: notifications[index]), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5));
                    },
                    itemCount: notifications.length,
                  ),
      (loadMore) ?
      Container(
        color: Colors.white12,
        child: Align(child: CustomLoading(), alignment: AlignmentDirectional.center,),) :
      Container()
    ]))
          )
          ),
        ],)
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if ((!(widget.state is LoadingUserState)) && (!loadMore)) {
      if (hasNext) {
        if (controller.position.pixels >
            (controller.position.maxScrollExtent * .75)) {
          if (!loadMore) {
            if (mounted) {
              setState(() {
                loadMore = true;
                currentPage = currentPage + 1;
                if (!widget.bloc.isClosed)
                  widget.bloc.add(GetNotificationsEvent(currentPage));
              });
            }
          }
        }
      }
    }
  }
}