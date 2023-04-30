import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<List<String>> valueNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) => CustomSelection(
          items: List.generate(100, (index) => index.toString()),
          selected: value,
          onChanged: (onChanged) {
            valueNotifier.value = onChanged;
            print(onChanged);
          },
        ),
      ),
    );
  }
}

class CustomSelection extends StatelessWidget {
  const CustomSelection({
    Key? key,
    required this.items,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final List<String> selected;
  final void Function(List<String> onChanged) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(selected.isEmpty
          ? "Please Select Up to 3 Items"
          : selected.join(",")),
      onTap: () => showSelectionDialog(context, items, selected, onChanged),
    );
  }
}

Future<void> showSelectionDialog(
    BuildContext context,
    List<String> items,
    List<String> selected,
    void Function(List<String> onChanged) onChanged) async {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      items: items,
      selected: selected,
      onChanged: onChanged,
    ),
  );
}

class Dialog extends StatefulWidget {
  const Dialog(
      {Key? key,
        required this.items,
        required this.selected,
        required this.onChanged})
      : super(key: key);

  final List<String> items;
  final List<String> selected;
  final void Function(List<String> onChanged) onChanged;

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
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: children,
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
