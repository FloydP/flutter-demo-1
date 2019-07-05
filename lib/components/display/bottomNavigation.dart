/*
 * Created by caowencheng on 2019-07-04
 * @Email 845982120@qq.com
 * @Website https://www.caowencheng.com
 */
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/homePage.dart';
import 'package:flutter_app/pages/coursePage.dart';
import 'package:flutter_app/pages/myPage.dart';
import 'package:flutter_app/utils/colorUtils.dart';
import 'package:flutter_app/assets/colors.dart';

class BottomNavigationWidget extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
	int _currentIndex = 0;
	List<Widget> list = List();

	@override
	void initState() {
		list
			..add(HomePage())
			..add(CoursePage())
			..add(MyPage());
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: list[_currentIndex],
			bottomNavigationBar: BottomNavigationBar(
				items: [
					BottomNavigationBarItem(
						icon: Icon(Icons.home),
						title: Text('首页')
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.email),
						title: Text('课程')
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.person),
						title: Text('我的')
					)
				],
				currentIndex: _currentIndex,
				onTap: (int index) {
					setState(() {
						_currentIndex = index;
					});
				},
				type: BottomNavigationBarType.fixed,
				backgroundColor: Color(ColorUtils.fromHexString(ColorsLibrary.themeColor)),
				selectedItemColor: Color(ColorUtils.fromHexString(ColorsLibrary.whiteColor)),
				unselectedItemColor: Color(ColorUtils.fromHexString(ColorsLibrary.inactiveTabBarItemColor)),
			),
		);
	}
}