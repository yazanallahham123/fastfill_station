
import 'package:flutter/material.dart';

import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';

class CustomDropDownButton extends StatefulWidget{

  final ValueChanged<String?>? onChanged;
  final List<String> items;
  final String? currentValue;
  final Widget? popupTitle;
  final Icon? icon;

  CustomDropDownButton({this.onChanged, required this.items, this.currentValue, this.popupTitle, this.icon});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton>
{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: SizeConfig().h(75),
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
              borderRadius: radiusAll16,
              color: Colors.white
          ),
      child:
      Padding(child:
      InkWell(child:
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

      Align(child:
       (widget.currentValue != null) ?

      Text(widget.currentValue!, style: TextStyle(color: Colors.black38),) :

      Container(),

     alignment: AlignmentDirectional.centerStart,),
      (widget.icon != null ) ? Icon(widget.icon!.icon)
          : Container()
      ]),
        onTap: () {
          showDialog(context: context, builder: (context) => new AlertDialog(
              title: widget.popupTitle,
              content:
              Container(
                width: SizeConfig().w(100),
                height: SizeConfig().h(140),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (BuildContext con, int index) {
                      return ListTile(title: Text(widget.items[index]),
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              widget.onChanged?.call(widget.items[index]);
                              Navigator.pop(context);
                            });
                          }
                        },
                      );
                    }),
              )
          ));
        },
      ), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),));
  }
}



