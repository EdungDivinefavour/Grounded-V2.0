import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/parent/add_child.dart';
import 'package:grounded/screens/parent/add_task.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/components/custom_scaffold.dart';

class HomeParent extends StatefulWidget {
  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {
  final _authService = AuthenticationService.instance;
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
      body: SafeArea(
        child: children.isEmpty
            ? emptyWidget
            : ListView.builder(
                shrinkWrap: true,
                itemCount: children.length,
                itemBuilder: (_, index) {
                  return _buildEachChild(children[index]);
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddChildScreen,
        child: SVGIcon(icon: AppIcons.add, size: 25),
      ),
    );
  }

  // TODO: Delete text widget and properly build the proper widget here
  // Ensure to wrap it in an inkwell and set the onPress/onTap for this to _openAddTaskScreen
  Widget _buildEachChild(Child child) {
    return Text(child.name);
  }

  void _getChildren() async {
    EasyLoading.show();
    final parentInfo =
        await _firestoreService.getParentInfo(_authService.currentUser!.uid);

    EasyLoading.dismiss();
    setState(() {
      children = parentInfo.children;
    });
  }

  void _openAddTaskScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddTask()));
  }

  void _openAddChildScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddChild()));
  }
}
