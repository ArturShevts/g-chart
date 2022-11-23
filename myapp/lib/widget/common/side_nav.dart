import 'package:flutter/material.dart';
import 'package:myapp/page/calendar/calendar_page.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/cover.jpeg'),
              ),
            ),
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.note_add),
            title: const Text('Notes'),
            //ontap navigate to notes page

            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('Calendar'),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CalendarsPage()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
