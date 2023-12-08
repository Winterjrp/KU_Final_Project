import 'package:flutter/material.dart';

typedef SearchCallback = void Function({required String searchText});

class FilterSearchBar extends StatelessWidget {
  final SearchCallback onSearch;
  final TextEditingController textEditingController;

  const FilterSearchBar({
    Key? key,
    required this.onSearch,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (searchText) {
        onSearch(searchText: searchText);
      },
      controller: textEditingController,
      style: const TextStyle(fontSize: 19),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: 'ค้นหาวัตถุดิบ',
        hintStyle:
            const TextStyle(fontSize: 18, height: 1.9, color: Colors.grey),
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        suffixIcon: textEditingController.text.isNotEmpty
            ? IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  textEditingController.clear();
                  onSearch(searchText: '');
                },
                icon: const Icon(
                  Icons.close,
                  // color: kGreyColor,
                  size: 18,
                ),
              )
            : Transform.scale(
                scale: 2.8,
                child: const Icon(
                  Icons.search,
                  // color: kGreyColor,
                  size: 10,
                ),
              ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            // color: kLightBlueColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
