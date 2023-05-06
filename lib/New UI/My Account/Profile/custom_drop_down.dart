import 'package:flutter/material.dart';
import 'package:vakalat_flutter/helper.dart';

import '../../../color/customcolor.dart';

class CustomSelection extends StatelessWidget {
  const CustomSelection({
    Key? key,
    required this.items,
    required this.selected,
    required this.onChanged,
    required this.onDone,
    required this.controller,
  }) : super(key: key);

  final List<String> items;
  final List<String> selected;
  final void Function(List<String> onChanged) onChanged;
  final void Function() onDone;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.none,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dialog(
                items: items,
                selected: selected,
                onChanged: onChanged,
                onDone: onDone,
              ),
            )),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          border: OutlineInputBorder(),
          labelText: "Please Select category",
          // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        ),
      ),
    );
    // return ListTile(
    //   title: const Text("Please Select"),
    //   subtitle: Text(selected.join(",")),
    //   onTap: () =>
    //       // showSelectionDialog(context, items, selected, onDone, onChanged),
    // );
  }
}
//
// Future<void> showSelectionDialog(
//     BuildContext context,
//     List<String> items,
//     List<String> selected,
//     void Function() onDone,
//     void Function(List<String> onChanged) onChanged) async {
//   Dialog(
//     items: items,
//     selected: selected,
//     onChanged: onChanged,
//     onDone: onDone,
//   );
// }

class Dialog extends StatefulWidget {
  const Dialog({
    Key? key,
    required this.items,
    required this.selected,
    required this.onChanged,
    required this.onDone,
  }) : super(key: key);

  final List<String> items;
  final List<String> selected;
  final void Function(List<String> onChanged) onChanged;
  final void Function() onDone;

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  List<String> selectedItem = <String>[];
  List<Widget> children = <Widget>[];

  @override
  void initState() {
    selectedItem = widget.selected;
    children = widget.items
        .map((element) => SelectionTile(
              key: Key(element),
              title: element,

              isSelected: selectedItem.contains(element) ? true : false,
              onChanged: (String onChanged, bool value) {
                if (value) {
                  selectedItem.add(onChanged);
                } else {
                  selectedItem.remove(onChanged);
                }
                widget.onChanged(selectedItem);
              },
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [TextButton(
            onPressed: widget.onDone,
            child: const Text("Done",style: TextStyle(fontSize: 16,color: Colors.white),),
          ),],
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionTile extends StatelessWidget {
  const SelectionTile(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.onChanged})
      : super(key: key);

  final String title;
  final bool isSelected;
  final void Function(String onChanged, bool isAdded) onChanged;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> valueNotifier = ValueNotifier(isSelected);
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(title),
      trailing: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) => Checkbox(
          value: value,
          onChanged: (value) {
            valueNotifier.value = value!;
            if (value == true) {
              onChanged(title, true);
            } else {
              onChanged(title, false);
            }
          },
        ),
      ),
    );
  }
}
