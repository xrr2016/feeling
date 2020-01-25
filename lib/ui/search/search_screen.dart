import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future _searchResult(String query) async {
    print(query);
    setState(() {
      _isSearching = true;
    });
    _controller.clear();
    return Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            labelText: 'Search something...',
          ),
          maxLines: 1,
          onSubmitted: (String query) {
            _searchResult(query);
          },
          focusNode: _focusNode,
          autofocus: true,
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onTap: () => _focusNode.requestFocus(),
        ),
      ),
    );
  }
}
