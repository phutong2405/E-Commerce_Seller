import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchFieldView extends StatefulWidget {
  final AppBloc appBloc;
  const SearchFieldView({
    super.key,
    required this.appBloc,
  });

  @override
  State<SearchFieldView> createState() => _SearchFieldViewState();
}

class _SearchFieldViewState extends State<SearchFieldView> {
  late final TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      child: TextField(
        controller: textController,
        // textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        decoration: InputDecoration(
          // hintText: 'Dicktionary',
          isDense: true,
          filled: true,
          prefixIcon: textController.text.isEmpty
              ? const Icon(
                  CupertinoIcons.search,
                )
              : IconButton(
                  onPressed: () {
                    textController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ),
                ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
              size: 22,
            ),
          ),
          fillColor: Colors.white,
          iconColor: const Color.fromRGBO(255, 255, 255, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          textController.text = value;
        },
      ),
    );
  }
}
