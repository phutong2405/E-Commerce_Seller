import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/search_field_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final AppBloc appBloc;
  const SearchPage({super.key, required this.appBloc});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.arrow_left,
            )),
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 20),
        ),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 30),
            child: SearchFieldView(
              appBloc: widget.appBloc,
            )),
      ),
    );
  }
}
