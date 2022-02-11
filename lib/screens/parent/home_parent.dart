import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/add_child.dart';
import 'package:grounded/screens/parent/add_task.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/components/custom_scaffold.dart';

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
        backgroundColor: ThemeColors.primary,
        child: SVGIcon(icon: AppIcons.add, size: 25),
      ),
    );
  }

  // TODO: Delete text widget and properly build the actual widget here
  Widget _buildEachChild(Child child) {
    return InkWell(
      onTap: () {
        _openAddTaskScreen(child);
      },
      child: Text(child.name),
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
