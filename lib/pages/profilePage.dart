import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profilePicUrl = 'https://pbs.twimg.com/media/DZZmAyxW4AAJHrn.jpg';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _profilePic(),
            _names(),
            _overallStatistics(),
            _displayBio(),
            _recentActivity(),
            _projects(),
          ],
        ),
      ),
    );
  }

  Widget _profilePic() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              profilePicUrl
            ),
            fit: BoxFit.cover
          )
        ),
        width: 64,
        height: 64,
      ),
    );
  }

  Widget _names() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Hussien',
            style: Theme.of(context).textTheme.headline,
          ),
          Text(
            'hussien4321',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget _displayBio(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _header('Bio'),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[350]
          ),
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 16.0),
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Hello everyone, i am new to the flutter community and flutter beacon!',
            textScaleFactor: 1.2,
          ),
        )
      ],
    );
  }
  
  Widget _recentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _header('Recent activity'),
        _buildActivityGraph(),
      ],
    );
            
  }
  Widget _overallStatistics(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildStatisticTab(0, 'Days of flutter'),
        _buildStatisticTab(0, 'Projects', isEnd: true),
      ],
    );
  }

  Widget _buildStatisticTab(int count, String name, {bool isEnd = false}){
    return Expanded(
          child: Container(
        decoration: isEnd ? null :BoxDecoration(
          border: BorderDirectional(
            end: BorderSide(
              color: Colors.grey[300],
              width: 0.5
            )
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('$count', style: Theme.of(context).textTheme.title),
            Text(name, style: Theme.of(context).textTheme.subhead),
          ],
        ),
      ),
    );
  }

  
  Widget _buildActivityGraph() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        itemCount: 30,
        itemBuilder: (ctx, index) => Container(
          color: index%2 == 0 ? Colors.grey : Colors.blue,
          margin: EdgeInsets.all(4.0)
        ),
      ),
    );
  }

  Widget _projects(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _header('Projects'),
        _loadProjects(),
      ],
    );
  }

  Widget _loadProjects() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'This user has no projects yet',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Padding(
      padding: const EdgeInsets.only(left : 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title
      ),
    );
  }
}