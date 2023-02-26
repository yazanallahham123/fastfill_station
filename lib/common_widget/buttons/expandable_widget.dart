
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/app_colors.dart';
import '../../helper/const_sizes.dart';
import '../../helper/const_styles.dart';
import '../../helper/font_styles.dart';
import '../../helper/size_config.dart';


class ExpandableWidget extends StatefulWidget {
  final String aboveTitle;
  final List<String> list;
  final bool multiChoice;
  final List<int> selectedIndexes;

  const ExpandableWidget(
      {Key? key,
      required this.aboveTitle,
      required this.list,
      required this.multiChoice,
      required this.selectedIndexes,
      })
      : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();

  int getCurrentIndex()=>currentOption[0];
  List<int> getCurrentOptions()=>currentOption;
}
List<int> currentOption = [];

class _ExpandableWidgetState extends State<ExpandableWidget>
    with TickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  final customDuration = const Duration(seconds: 1);

  @override
  void initState() {
    super.initState();

    currentOption = widget.selectedIndexes;

    _controller = AnimationController(duration: customDuration, vsync: this);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  }

  _toggleContainer() {
    print(_animation.status);
    if (_animation.status != AnimationStatus.completed)
      _controller
          .forward()
          .whenComplete(() => setState(() => isOpened = !isOpened));
    else
      _controller
          .animateBack(0, duration: customDuration)
          .whenComplete(() => setState(() => isOpened = !isOpened));
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsetsDirectional.only(bottom: SizeConfig().h(6)),
        child: Text(widget.aboveTitle, style: smallPrimaryColor2()),
      ),
      InkWell(
          onTap: () {
            _toggleContainer();
          },
          child: ClipRRect(
            borderRadius: radiusAll14,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: AnimatedContainer(
              duration: customDuration,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: radiusAll14,
                  border: Border.all(
                      width: SizeConfig().w(1),
                      color: const Color(0xffd8e0e5))),
              child: Column(
                children: [
                  Container(
                    height: SizeConfig().h(47),
                    decoration: BoxDecoration(
                        border: isOpened
                            ? Border(
                                bottom: BorderSide(
                                    width: SizeConfig().w(1),
                                    color: const Color(0xffd8e0e5)))
                            : null),
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig().w(20)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child:Text(
                              currentOption.isNotEmpty
                                  ? buildChoices()
                                  : '${translate("labels.select")} ${widget.aboveTitle.toLowerCase()}',
                              style: currentOption.isNotEmpty
                                  ? smallPrimaryColor2()
                                  : smallCustomGreyColor4()
                          )),
                          SvgPicture.asset(
                              isOpened
                                  ? 'assets/svg/path_34544.svg'
                                  : 'assets/svg/path_32877.svg',
                              color: const Color(0xff333542))
                        ]),
                  ),

                  // options widget
                  SizeTransition(
                      sizeFactor: _animation,
                      axis: Axis.vertical,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: radiusBottom14),
                        padding: EdgeInsetsDirectional.only(bottom: SizeConfig().h(25)),
                        child: Column(
                            children: List.generate(
                                widget.list.length,
                                (index) => InkWell(
                                      onTap: () {
                                        if (widget.multiChoice) {
                                          if (currentOption.contains(index))
                                            setState(() =>
                                                currentOption.remove(index));
                                          else
                                            setState(
                                                () => currentOption.add(index));
                                        } else
                                          setState(
                                              () => currentOption = [index]);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: SizeConfig().w(13)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: customGreyColor3,
                                                      width:
                                                          SizeConfig().w(1)))),
                                          padding: EdgeInsetsDirectional.only(
                                              top: SizeConfig().h(18),
                                              bottom: SizeConfig().h(16)),
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: h12,
                                                  width: h12,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.elliptical(
                                                                9999.0,
                                                                9999.0)),
                                                    color: isSelected(index)
                                                        ? primaryColor1
                                                        : null,
                                                    border: Border.all(
                                                        width: width1,
                                                        color: isSelected(index)
                                                            ? primaryColor1
                                                            : primaryColor2),
                                                  ),
                                                  child: isSelected(index)
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.all(
                                                                  SizeConfig()
                                                                      .h(2)),
                                                          child: SvgPicture.asset(
                                                              'assets/svg/path_32878.svg'),
                                                        )
                                                      : null),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          SizeConfig().w(8)),
                                                  child: Text(
                                                      widget.list[index],
                                                      style:
                                                          mediumLowWeightPrimaryColor2()))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))),
                      ))
                ],
              ),
            ),
          ))
    ]);
  }

  bool isSelected(int index) =>
      currentOption.isNotEmpty && currentOption.contains(index);


  String buildChoices() {
    if (widget.multiChoice) {
      String value = "";
      currentOption.forEach((element) {
        value += widget.list[element];
        if (currentOption.last != element) value += ", ";
      });
      return value;
    }
    return widget.list[currentOption.first];
  }
}
