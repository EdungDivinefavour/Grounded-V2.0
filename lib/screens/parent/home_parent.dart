import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/center_text.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/add_child.dart';
import 'package:grounded/screens/parent/add_task.dart';
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
  List<Child> children = [];

  @override
  void initState() {
    super.initState();

    _getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(hasDrawer: true),
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
            children.isEmpty
                ? CenterText(
                    text:
                        "You haven't added any children yet. Click the button below to add children")
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: children.length,
                    itemBuilder: (_, index) {
                      return _buildEachChild(children[index]);
                    }),
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

  // TODO: Delete text widget and properly build the actual widget here
  Widget _buildEachChild(Child child) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            UserImage(imageURL: child.profilePhoto, size: 60),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(child.name, style: TextStyles.semiBold),
                    SizedBox(width: 5),
                    Text("(" + child.age.toString() + " years old)")
                  ],
                ),
                SizedBox(height: 10),
                Text("Grade " + child.grade.toString()),
                SizedBox(height: 10),
                Text("Login Token - " + child.loginToken)
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        FlatButton(
            onPressed: () {
              _openAddTaskScreen(child);
            },
            child: Text(
              'Assign New Task',
              style: TextStyles.bold.copyWith(fontSize: 16),
            )),
        Divider(height: 5, thickness: 1)
      ],
    );
  }

  void _getChildren() async {
    EasyLoading.show();
    final result = await _firestoreService.getChildrenForParent(widget.parent);

    EasyLoading.dismiss();
    setState(() {
      children = result;
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
      children.add(result as Child);
    });
  }
}
