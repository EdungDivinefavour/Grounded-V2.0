import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/center_text.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/add_child.dart';
import 'package:grounded/screens/parent/add_task/add_task.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/string_utils.dart';

class HomeParent extends StatefulWidget {
  final Parent parent;
  const HomeParent({required this.parent});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {
  final _firestoreService = FirestoreService.instance;
  List<Child> _children = [];

  @override
  void initState() {
    super.initState();

    _getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bubblePosition: BackgroundBubblePosition.centerLeft,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ScreenTitle(
                title: "Hey " + shortenToFirstOnly(widget.parent.name),
                subTitle: "Pick a child to asign them tasks",
                isWhiteBackround: true),
            SizedBox(height: 20),
            _children.isEmpty
                ? CenterText(
                    text:
                        "You haven't added any children yet. Click the button below to add children")
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _children.length,
                        itemBuilder: (_, index) {
                          return _buildEachChild(_children[index]);
                        }),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddChildScreen,
        backgroundColor: ThemeColors.primary,
        child: SVGIcon(icon: AppIcons.add, size: 25),
      ),
    );
  }

  Widget _buildEachChild(Child child) {
    final textStyle = TextStyles.regular.copyWith(fontSize: 15);

    return InkWell(
      onTap: () {
        _openChildOptionsSheet(child);
      },
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              children: [
                UserImage(imageURL: child.profilePhoto, size: 90),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(child.name, style: TextStyles.semiBold),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text("${child.age} years old", style: textStyle),
                    SizedBox(height: 5),
                    Text("Grade ${child.grade}", style: textStyle),
                    SizedBox(height: 5),
                    Text("Login Token - " + child.loginToken, style: textStyle)
                  ],
                )
              ],
            ),
            SizedBox(height: 15),
            TextButton(
                onPressed: () {
                  _openAddTaskScreen(child);
                },
                child: Text(
                  'Assign New Task',
                  style: TextStyles.bold
                      .copyWith(fontSize: 16, color: ThemeColors.darkElement),
                )),
            Divider(height: 5, thickness: 1)
          ],
        ),
      ),
    );
  }

  void _openChildOptionsSheet(Child child) async {
    final result = await showModalActionSheet<String>(
        context: context,
        title: "Select option",
        actions: [
          SheetAction(
              key: "delete", label: "Delete child", isDestructiveAction: true),
        ]);

    if (result != "delete") return;
    _openConfirmChildDeleteDialog(child);
  }

  void _openConfirmChildDeleteDialog(Child child) async {
    final result = await showAlertDialog<String>(
      context: context,
      title: "Are you sure?",
      message:
          "Please confirm you want to perform this action as it is irreversible.",
      actions: [
        AlertDialogAction(key: "proceed", label: "Proceed"),
        AlertDialogAction(key: "cancel", label: "Cancel"),
      ],
    );

    if (result != "proceed") return;
    _firestoreService.deleteChild(child);

    setState(() {
      _children.remove(child);
    });
  }

  void _getChildren() async {
    EasyLoading.show();
    final result = await _firestoreService.getChildrenForParent(widget.parent);

    EasyLoading.dismiss();
    setState(() {
      _children = result;
    });
  }

  void _openAddTaskScreen(Child child) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => AddTask(parent: widget.parent, child: child)),
    );
  }

  void _openAddChildScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddChild(parent: widget.parent)),
    );
    if (result == null) return;

    setState(() {
      _children.add(result as Child);
    });
  }
}
