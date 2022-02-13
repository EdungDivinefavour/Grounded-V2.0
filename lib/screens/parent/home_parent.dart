import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/empty_widget.dart';
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
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.list_outlined),
                Spacer(),
                Icon(Icons.notifications)
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hey James",
                style: TextStyles.extraBold.copyWith(fontSize: 24),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pick a child to asign them tasks",
                style: TextStyles.regular,
              ),
            ),
            SizedBox(height: 20),
            children.isEmpty
                ? emptyWidget
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
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              UserImage(imageURL: child.profilePhoto, size: 60),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(child.name, style: TextStyles.medium),
                      SizedBox(width: 5),
                      Text("(" + child.age.toString() + " years old)")
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("Grade " + child.grade.toString()),
                  SizedBox(height: 5),
                  Text("Login Token - " + child.loginToken)
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          FlatButton(
              onPressed: () {
                _openAddTaskScreen(child);
              },
              child: Text(
                'Assign New Task',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
          Divider(height: 5, thickness: 1)
        ],
      ),
    );
  }

  void _getChildren() async {
    EasyLoading.show();
    final parentInfo = await _firestoreService.getParentInfo(widget.parent.id);

    EasyLoading.dismiss();
    setState(() {
      children = parentInfo.children;
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddChild()));
  }
}
