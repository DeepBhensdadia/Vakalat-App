
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/utils/constant.dart';

import '../color/customcolor.dart';
import '../model/GetAllCategory.dart';
import '../model/clsCitiesResponseModel.dart';
import '../model/clsCountriesResponseModel.dart';
import '../model/clsStateResponseModel.dart';
import '../model/clsUserTypeResponseModel.dart';

class next_page_ui extends StatelessWidget {
  const next_page_ui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: const Center(
                  child: Text(
                '1',
                style: TextStyle(color: Colors.black45),
              )),
            ),
          ),
        ),
        Text(
          '------------------',
          style: TextStyle(color: Colors.grey.shade500),
        ),
        Card(
          elevation: 2,
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade500),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Center(
                  child: Text(
                '2',
                style: TextStyle(color: Colors.grey.shade500),
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class Register_now_ui extends StatelessWidget {
  const Register_now_ui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.grey.shade300,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.green),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.green,
              )),
            ),
          ),
        ),
        Text(
          '------------------',
          style: TextStyle(color: Colors.grey.shade500),
        ),
        Card(
          elevation: 4,
          // color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: const Center(
                  child: Text(
                '2',
                style: TextStyle(color: Colors.black54),
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextfield extends StatelessWidget {
  final Controller;

  final String labelname;
  String? Function(String?)? validator;
  final suffixicon;

  final int? maxlength;
  final TextInputType? type;
  CustomTextfield(
      {Key? key,
      this.Controller,
      this.validator,
      required this.labelname,
      this.suffixicon,
      this.maxlength,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: Controller,
        maxLength: maxlength,
        keyboardType: type,
        // focusNode: edtEmail,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            border: const OutlineInputBorder(),
            labelText: labelname,
            // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
            suffixIcon: Icon(suffixicon)),
        validator: validator,
      ),
    );
  }
}

class CustomDropDownCountry extends StatefulWidget {
  const CustomDropDownCountry({
    Key? key,
    required this.country,
    required this.onSelection,
    this.isSelectFirst = false,
    this.initialValue,
  }) : super(key: key);

  final List<Country> country;
  final void Function(String?) onSelection;
  final String? initialValue;
  final bool isSelectFirst;

  @override
  State<CustomDropDownCountry> createState() => _CustomDropDownCountryState();
}

class _CustomDropDownCountryState extends State<CustomDropDownCountry> {
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: screenwidth(context, dividedby: 1),
      decoration: Const().decorationfield,
      child: SearchChoices<String>.single(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        underline: Container(
          color: Colors.transparent,
        ),
        items: widget.country
            .map<DropdownMenuItem<String>>(
              (element) => DropdownMenuItem<String>(
            value: element.countryId,
            child: Text(element.countryName),
          ),
        )
            .toList(),
        value: _selectedCountry,
        hint: "Select Country",
        searchHint: "Select Country",
        onChanged: (value) {
          setState(() {
            _selectedCountry = value;
            print(value);
          });
          widget.onSelection(value);
        },
        searchFn: (String keyword, List<DropdownMenuItem> items) {
          List<int> filterdata = [];
          if (items.isNotEmpty && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              for (DropdownMenuItem item in items) {
                if (!filterdata.contains(i) &&
                    k.isNotEmpty &&
                    ((item.child as Text).data
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  filterdata.add(i);
                }
                i++;
              }
            });
          }
          if (keyword.isEmpty) {
            filterdata = Iterable<int>.generate(items.length).toList();
          }
          return (filterdata);
        },
        searchResultDisplayFn: (
            {required displayItem,
              required emptyListWidget,
              required itemTapped,
              required itemsToDisplay,
              required scrollController,
              required thumbVisibility}) {
          return Expanded(
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: thumbVisibility,
              child: itemsToDisplay.isEmpty
                  ? emptyListWidget
                  : ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  int itemIndex = itemsToDisplay[index].item1;
                  DropdownMenuItem item = itemsToDisplay[index].item2;
                  bool isItemSelected = itemsToDisplay[index].item3;
                  return InkWell(
                    onTap: () {
                      itemTapped(
                        itemIndex,
                        item.value,
                        isItemSelected,
                      );
                    },
                    child: displayItem(
                      item,
                      isItemSelected,
                    ),
                  );
                },
                itemCount: itemsToDisplay.length,
              ),
            ),
          );
        },
        isExpanded: true,
        displayClearIcon: false,
        dialogBox: true,
      ),
    );
  }
}

class CustomDropDownState extends StatefulWidget {
  const CustomDropDownState({
    Key? key,
    required this.raja,
    required this.onSelection,
    this.initialValue,
  }) : super(key: key);

  final List<Rajya> raja;
  final void Function(String?) onSelection;
  final String? initialValue;
  @override
  State<CustomDropDownState> createState() => _CustomDropDownStateState();
}

class _CustomDropDownStateState extends State<CustomDropDownState> {
  String?  _selectedstate;
  @override
  void initState() {
    _selectedstate= widget.initialValue;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: screenwidth(context, dividedby: 1),
      decoration: Const().decorationfield,
      child: SearchChoices<String>.single(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        underline: Container(
          color: Colors.transparent,
        ),
        items: widget.raja
            .map<DropdownMenuItem<String>>(
              (element) => DropdownMenuItem<String>(
            value: element.stateId,
            child: Text(element.stateName),
          ),
        )
            .toList(),
        value:  _selectedstate,
        hint: "Select State",
        searchHint: "Select State",
        onChanged: (value) {
          setState(() {
            _selectedstate = value;
            print(value);
          });
          widget.onSelection(value);
        },
        searchFn: (String keyword, List<DropdownMenuItem> items) {
          List<int> filterdata = [];
          if (items.isNotEmpty && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              for (DropdownMenuItem item in items) {
                if (!filterdata.contains(i) &&
                    k.isNotEmpty &&
                    ((item.child as Text).data
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  filterdata.add(i);
                }
                i++;
              }
            });
          }
          if (keyword.isEmpty) {
            filterdata = Iterable<int>.generate(items.length).toList();
          }
          return (filterdata);
        },
        searchResultDisplayFn: (
            {required displayItem,
              required emptyListWidget,
              required itemTapped,
              required itemsToDisplay,
              required scrollController,
              required thumbVisibility}) {
          return Expanded(
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: thumbVisibility,
              child: itemsToDisplay.isEmpty
                  ? emptyListWidget
                  : ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  int itemIndex = itemsToDisplay[index].item1;
                  DropdownMenuItem item = itemsToDisplay[index].item2;
                  bool isItemSelected = itemsToDisplay[index].item3;
                  return InkWell(
                    onTap: () {
                      itemTapped(
                        itemIndex,
                        item.value,
                        isItemSelected,
                      );
                    },
                    child: displayItem(
                      item,
                      isItemSelected,
                    ),
                  );
                },
                itemCount: itemsToDisplay.length,
              ),
            ),
          );
        },
        isExpanded: true,
        displayClearIcon: false,
        dialogBox: true,
      ),
    );
  }
}

class CustomDropCities extends StatefulWidget {
  final List<City> citi;
  final void Function(String?) onSelection;
  final String? initialValue;

  const CustomDropCities(
      {super.key,
      required this.citi,
      required this.onSelection,
      this.initialValue});
  @override
  State<CustomDropCities> createState() => _CustomDropCitiesState();
}

class _CustomDropCitiesState extends State<CustomDropCities> {
  String?  _selectedcity;
  @override
  void initState() {
     _selectedcity = widget.initialValue;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: screenwidth(context, dividedby: 1),
      decoration: Const().decorationfield,
      child: SearchChoices<String>.single(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        underline: Container(
          color: Colors.transparent,
        ),
        items: widget.citi
            .map<DropdownMenuItem<String>>(
              (element) => DropdownMenuItem<String>(
            value: element.cityId,
            child: Text(element.cityName),
          ),
        )
            .toList(),
        value:  _selectedcity,
        hint: "Select City",
        searchHint: "Select City",
        onChanged: (value) {
          setState(() {
             _selectedcity = value;
            print(value);
          });
          widget.onSelection(value);
        },
        searchFn: (String keyword, List<DropdownMenuItem> items) {
          List<int> filterdata = [];
          if (items.isNotEmpty && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              for (DropdownMenuItem item in items) {
                if (!filterdata.contains(i) &&
                    k.isNotEmpty &&
                    ((item.child as Text).data
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  filterdata.add(i);
                }
                i++;
              }
            });
          }
          if (keyword.isEmpty) {
            filterdata = Iterable<int>.generate(items.length).toList();
          }
          return (filterdata);
        },
        searchResultDisplayFn: (
            {required displayItem,
              required emptyListWidget,
              required itemTapped,
              required itemsToDisplay,
              required scrollController,
              required thumbVisibility}) {
          return Expanded(
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: thumbVisibility,
              child: itemsToDisplay.isEmpty
                  ? emptyListWidget
                  : ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  int itemIndex = itemsToDisplay[index].item1;
                  DropdownMenuItem item = itemsToDisplay[index].item2;
                  bool isItemSelected = itemsToDisplay[index].item3;
                  return InkWell(
                    onTap: () {
                      itemTapped(
                        itemIndex,
                        item.value,
                        isItemSelected,
                      );
                    },
                    child: displayItem(
                      item,
                      isItemSelected,
                    ),
                  );
                },
                itemCount: itemsToDisplay.length,
              ),
            ),
          );
        },
        isExpanded: true,
        displayClearIcon: false,
        dialogBox: true,
      ),
    );
  }
}



class CustomDropDownUser_Type extends StatefulWidget {
  final List<UserType> user_type;
  final void Function(String?) onSelection;

  const CustomDropDownUser_Type(
      {super.key, required this.user_type, required this.onSelection});

  @override
  State<CustomDropDownUser_Type> createState() =>
      _CustomDropDownUser_TypeState();
}

class _CustomDropDownUser_TypeState extends State<CustomDropDownUser_Type> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   valueNotifier = ValueNotifier<String>(widget.user_type.first.utId);
  //   super.initState();
  // }

  ValueNotifier<String?> valueNotifier = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: screenwidth(context, dividedby: 1),
      decoration: Const().decorationfield,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) => DropdownButton<String>(
            underline: Container(color: Colors.transparent),
            hint: const Text('Select User Type'),
            // iconSize: ,
            // icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            // itemHeight: 10,
            value: value,
            items: widget.user_type
                .map<DropdownMenuItem<String>>(
                  (element) => DropdownMenuItem<String>(
                    value: element.utId,
                    child: Text(element.utName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              widget.onSelection(value);
              valueNotifier.value = widget.user_type
                  .where((element) => element.utId.contains(value!))
                  .toList()[0]
                  .utId;
            },
          ),
        ),
      ),
    );
  }
}

class Button_For_Update_Save extends StatelessWidget {
  final String text;

  Function() onpressed;

  Button_For_Update_Save(
      {Key? key, required this.text, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        width: screenwidth(context, dividedby: 1),
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor().colorPrimary,
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onPressed: onpressed,
            child: Text(text)));
  }
}


class Select_Category extends StatefulWidget {
  const Select_Category({
    Key? key,
    required this.categori,
    required this.onSelection,
    this.isSelectFirst = false,
    this.initialValue,
  }) : super(key: key);

  final GetAllCategory categori;
  final void Function(String?) onSelection;
  final String? initialValue;
  final bool isSelectFirst;

  @override
  State<Select_Category> createState() => _Select_CategoryState();
}

class _Select_CategoryState extends State<Select_Category> {
 String? _selectedcategori ;

  @override
  void initState() {
    super.initState();
    _selectedcategori = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: screenwidth(context, dividedby: 1),
      decoration: Const().decorationfield,
      child: SearchChoices<String>.single(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        underline: Container(
          color: Colors.transparent,
        ),
        items: widget.categori.getAllCategory()
            .map<DropdownMenuItem<String>>(
              (element) => DropdownMenuItem<String>(
            value: element.id,
            child: Text(element.name),
          ),
        )
            .toList(),
        // futureSelectedValues: ,
       value: _selectedcategori,
//         selectedItems: _selectedcategori.map((e) => int.pa).toList(),
        hint: "Select Categories",
        searchHint: "Select Categories",
        onChanged: (value) {
          setState(() {
            _selectedcategori = value;
            print(value);
          });
          widget.onSelection(value);
        },
        searchFn: (String keyword, List<DropdownMenuItem> items) {
          List<int> filterdata = [];
          if (items.isNotEmpty && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              for (DropdownMenuItem item in items) {
                if (!filterdata.contains(i) &&
                    k.isNotEmpty &&
                    ((item.child as Text).data
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  filterdata.add(i);
                }
                i++;
              }
            });
          }
          if (keyword.isEmpty) {
            filterdata = Iterable<int>.generate(items.length).toList();
          }
          return (filterdata);
        },
        searchResultDisplayFn: (
            {required displayItem,
              required emptyListWidget,
              required itemTapped,
              required itemsToDisplay,
              required scrollController,
              required thumbVisibility}) {
          return Expanded(
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: thumbVisibility,
              child: itemsToDisplay.isEmpty
                  ? emptyListWidget
                  : ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  int itemIndex = itemsToDisplay[index].item1;
                  DropdownMenuItem item = itemsToDisplay[index].item2;
                  bool isItemSelected = itemsToDisplay[index].item3;
                  return InkWell(
                    onTap: () {
                      itemTapped(
                        itemIndex,
                        item.value,
                        isItemSelected,
                      );
                    },
                    child: displayItem(
                      item,
                      isItemSelected,
                    ),
                  );
                },
                itemCount: itemsToDisplay.length,
              ),
            ),
          );
        },
        isExpanded: true,
        displayClearIcon: false,
        dialogBox: true,
      ),
    );
  }
}