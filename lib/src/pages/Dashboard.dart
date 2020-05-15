import 'package:flutter/material.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        dividerColor: Colors.grey,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chesta | Dashboard'),
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Login'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Einstellungen'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Download-Container'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Soziale Netzwerke'),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text('FAQ'),
                ),
              ];
            },
          ),
        ],
      ),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.create, size: 72.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('14.11.2015'),
                            Text(
                              'Medical Reports',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('PNEUMONIA, CHEST XRAY , VR'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('08:30 - 12:30 Uhr'),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 1.0),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Profil',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Blackboard',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Campus-Nachrichten',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Veranstaltungen',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Termine',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Prufengen',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Ansprechpartner',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person,
                      text: 'Modulportal',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.book,
                      text: 'Literaturrecherche',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    Key key,
    @required this.icon,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 0.6,
              child: FittedBox(
                child: Icon(icon),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 0.8,
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
