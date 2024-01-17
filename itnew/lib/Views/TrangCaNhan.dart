import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaNhan extends StatefulWidget {
  const CaNhan({super.key});

  @override
  State<CaNhan> createState() => _CaNhanState();
}

class _CaNhanState extends State<CaNhan> {
  FontsChu fontsChu = FontsChu();
  bool light = false;

  String status = 'Dark Theme';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider()..init(),
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider notifier, child) {
        Color textColor = notifier.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 24, 24, 24);
        return Scaffold(
          backgroundColor: notifier.isDarkMode ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(222, 0, 183, 255),
            title: Text(
              'Setting',
              style: TextStyle(
                  fontFamily: fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavi(index: 2),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      padding: const EdgeInsets.all(10),
                      child: ClipOval(
                        child: Icon(
                          Icons.account_circle,
                          size: 130,
                          color: textColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: textColor, // Màu của viền
                        ),
                      ),
                      child: Text(
                        'Login', // --------------------------------------------------- ĐĂNG NHẬP ----------------------------------
                        style: TextStyle(
                            fontFamily: fontsChu.fontInter == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isCurrent);
                        Navigator.pushNamed(context, '/daluu');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons
                                .bookmark, // ------------------------------------------------- LƯU TIN TỨC --------------------------------
                            color: Colors.green,
                            size: 50,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Saved',
                            style: TextStyle(
                                fontFamily: fontsChu.fontInter == 'Inter'
                                    ? 'Inter'
                                    : 'Kalam',
                                fontSize: 25,
                                color: textColor),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isCurrent);
                        Navigator.pushNamed(context, '/lichsu');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons
                                .access_time_filled, // ---------------------------------------- LỊCH SỬ --------------------------------
                            color: Colors.green,
                            size: 50,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'History',
                            style: TextStyle(
                                fontFamily: fontsChu.fontInter == 'Inter'
                                    ? 'Inter'
                                    : 'Kalam',
                                fontSize: 25,
                                color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  thickness: 2, // ------------------------- ĐỘ DÀY
                  color: Colors.grey, // ----------------- MÀU SẮC
                  indent: 1, // ---------------------------- LÙI SANG TRÁI
                  endIndent: 1, // ------------------------- LÙI SANG PHẢI
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                      height: 70,
                    ),
                    Text(
                      'Setting',
                      style: TextStyle(
                          fontFamily:
                              fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                          fontSize: 30,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                      height: 70,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.popUntil(
                              context, (route) => route.isCurrent);
                          Navigator.pushNamed(context, '/cochuvafontchu');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.format_color_text_outlined,
                              size: 40,
                              color: textColor,
                            ),
                            Text(
                              'Font & Size Text',
                              style: TextStyle(
                                  fontFamily: fontsChu.fontInter == 'Inter'
                                      ? 'Inter'
                                      : 'Kalam',
                                  fontSize: 25,
                                  color: textColor),
                            ),
                          ],
                        ))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                      height: 70,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontFamily:
                              fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                          fontSize: 25,
                          color: textColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Switch(
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.green,
                        // value: themeProvider.isDarkMode,
                        value: notifier.isDarkMode,
                        onChanged: (value) => notifier.changeTheme())
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'Delete account',
                            style: TextStyle(
                                fontFamily: fontsChu.fontInter == 'Inter'
                                    ? 'Inter'
                                    : 'Kalam',
                                fontSize: 25,
                                color: textColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.black, // Màu của viền
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: fontsChu.fontInter == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
