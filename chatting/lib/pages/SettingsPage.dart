import 'package:flutter/material.dart';

//import 'FriendsPage.dart';
enum SampleItem { editProfile, settings, signOut }
// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  
  const SettingsPage({super.key,});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String? language = "English";
  bool DarkMode = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold( key: const Key('profile-page'),
    resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Row(children: [
            Icon(Icons.settings),
            SizedBox(width: 10,),
            Center(child: Text("S E T T I N G S")),
            Expanded(child: SizedBox(width: 10,)),
        ],),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              /*Container(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("App Settings", style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color, fontSize: 20),),
                        ],
                      ),
                      onTap: () {
                      },
                    ),
                ),*/
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5), top: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                    leading: Icon(Icons.language_sharp, color: Theme.of(context).appBarTheme.iconTheme!.color,),

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Languages", style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color, fontSize: 20),),
                          const SizedBox(height: 5,),
                          Text(language!, style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
                        ],
                      ),
                      onTap: () {
                      },
                    ),
                ),
                Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                    leading: Icon(Icons.dark_mode, color: Theme.of(context).appBarTheme.iconTheme!.color,),

                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Dark Mode", style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color, fontSize: 20),),
                          const Expanded(child: SizedBox(width: 10,),),
                          Switch(
                            value: DarkMode,
                            onChanged: (value) {
                              setState(() {
                                DarkMode = value;
                              });
                            },
                            inactiveThumbColor: Colors.black,
                            inactiveTrackColor:  Colors.black,
                            activeTrackColor: Colors.white,
                            activeColor: Colors.white,
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          DarkMode = !DarkMode;
                        });
                      },
                    ),
                ),
                Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                    leading: Icon(Icons.info, color: Theme.of(context).appBarTheme.iconTheme!.color,),

                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("About us", style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color, fontSize: 20),),
                          const Expanded(child: SizedBox(width: 10,),),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text("v0.0.1", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                ),
                Container(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                      leading: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.secondary,),
                      title: Text("Account Settings", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20),),
                      onTap: () {
                      },
                    ),
                ),
                Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                    leading: Icon(Icons.pause_circle, color: Theme.of(context).appBarTheme.iconTheme!.color,),

                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Deactivate Account", style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color, fontSize: 20),),
                        ]
                      ),
                      onTap: () {},
                    ),
                ),
                Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
                ),
                child:
                  ListTile(
                    tileColor: Colors.transparent,
                    leading: const Icon(Icons.delete, color: Colors.red,),

                      title: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Delete Account", style: TextStyle(color: Colors.red, fontSize: 20),),
                        ]
                      ),
                      onTap: () {},
                    ),
                ),
            ]  
          ),
        )
    );
  }
}