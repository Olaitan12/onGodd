import 'package:flutter/material.dart';

import 'package:secured_parking/presentation/platform_adaptive.dart';
import 'package:secured_parking/styles/texts.dart';
import 'package:secured_parking/screens/main_tabs/news_tab.dart';
import 'package:secured_parking/screens/main_tabs/stats_tab.dart'; 
import 'package:secured_parking/screens/main_drawer.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => new MainScreenState();

}
class MainScreenState extends State<MainScreen> {
    
    PageController _tabController;
    String _title;
    int _index;

    @override
    void initState() {
        super.initState();
        _tabController = new PageController();
        _title = TabItems[0].title;
        _index = 0;
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            
            appBar: new PlatformAdaptiveAppBar(
                title: new Text(_title),
                platform: Theme.of(context).platform
            ),
            
            bottomNavigationBar: new PlatformAdaptiveBottomBar(
                currentIndex: _index,
                onTap: onTap,
                items: TabItems.map((TabItem item) {
                    return new BottomNavigationBarItem(
                        title: new Text(
                            item.title,
                            style: textStyles['bottom_label'],
                        ),
                        icon: new Icon(item.icon),
                    );
                }).toList(),
            ),

            body: new PageView(
                controller: _tabController,
                onPageChanged: onTabChanged,
                children: <Widget>[
                    new NewsTab(),
                    new StatsTab(), 
                ],
            ),

            drawer: new MainDrawer(),
        );
    }

    void onTap(int tab){
        _tabController.jumpToPage(tab);
    }

    void onTabChanged(int tab) {
        setState((){
            this._index = tab;
        });
        
        this._title = TabItems[tab].title;
    }

}

class TabItem {
    final String title;
    final IconData icon;

    const TabItem({ this.title, this.icon });
}

const List<TabItem> TabItems = const <TabItem>[
    const TabItem(title: 'Secured Parking', icon: Icons.verified_user),
    const TabItem(title: 'History', icon: Icons.timeline), 
];