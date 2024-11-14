import 'dart:async';
import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final String title;
  final String? initialString;
  final Function(String) onSearch;

  const AppSearchBar(
      {super.key,
      required this.onSearch,
      required this.title,
      this.initialString});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  Timer? timer;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialString != null && widget.initialString!.isNotEmpty) {
      _controller.text = widget.initialString ?? "";
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length ?? 0);
    }
    return Container(
      padding: const EdgeInsets.only(right: 0, left: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: Colors.black, width: 0.5),
        color: Colors.white,
      ),
      child: TextFormField(
          onChanged: (value) {
            onSearchTextEntered(value);
          },
          controller: _controller,
          decoration: InputDecoration(
              fillColor: null,
              hintText: widget.title,
              contentPadding: EdgeInsets.only(top: 12),
              hintStyle: const TextStyle(
                fontFamily: "Rosario_Reg",
                fontSize: 14,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  widget.onSearch("");
                },
                icon: Icon(
                  Icons.close,
                  color: _controller.text.isEmpty
                      ? Colors.transparent
                      : Colors.red,
                ),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: InputBorder.none),
          style: const TextStyle(
            fontFamily: "Rosario_Reg",
            fontSize: 14,
            color: Colors.black,
          )),
    );
  }

  void onSearchTextEntered(String value) {
    setState(() {});
    if (timer != null) {
      timer?.cancel();
    }

    timer = Timer(const Duration(milliseconds: 500), () {
      print(value);
      widget.onSearch(value);
    });
  }
}
