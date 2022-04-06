import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class DialogListItem extends StatefulWidget {
  final String title;
  final void Function(void Function()) stateSetter;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  DialogListItem({
    required this.title,
    required this.stateSetter,
    required this.isSelected,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  State<DialogListItem> createState() => _DialogListItemState();
}

class _DialogListItemState extends State<DialogListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.5, horizontal: 15),
      child: InkWell(
        onTap: () {
          widget.stateSetter.call(() {
            widget.onTap.call();
          });
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: 65,
            padding: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 190,
                  child: Text(
                    widget.title,
                    style: TextStyles.regular
                        .copyWith(fontSize: 15, color: widget.textColor),
                  ),
                ),
                Spacer(),
                widget.isSelected
                    ? Icon(Icons.check_circle,
                        size: 30, color: widget.iconColor)
                    : emptyWidget
              ],
            ),
          ),
        ),
      ),
    );
  }
}
