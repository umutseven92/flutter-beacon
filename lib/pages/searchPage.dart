import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {

  List<Widget> _createMockList() {
    var mockList = <Widget>[];

    for (int i = 0; i < 20; i++) {
      mockList.add(_createUserTile(
          'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F256FE13F54F1EE2A33',
          'User Name',
          '2.7 km'));
    }

    return mockList;
  }

  Widget _createUserTile(String profilePicURL, String name, String distance) {
    return ListTile(
      leading: Image.network(profilePicURL),
      title: Text(name),
      subtitle: Text(distance),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Closest Users'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                children: _createMockList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
