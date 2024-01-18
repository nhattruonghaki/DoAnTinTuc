import 'package:flutter/material.dart';

import 'package:itnew/Models/FontChange.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

class CaiDat extends StatefulWidget {
  const CaiDat({super.key});

  @override
  State<CaiDat> createState() => _CaiDatState();
}

class _CaiDatState extends State<CaiDat> {
  bool light = false;

  String status = 'Dark Theme';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FontTextProvider()..init()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()..init()),
      ],
      child: Consumer2<FontTextProvider, ThemeProvider>(
          builder: (context, fontProvider, themeProvider, child) {
        Color textColor = themeProvider.isDarkMode
            ? Colors.white
            : const Color.fromARGB(255, 24, 24, 24);
        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode ? Colors.black : Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isActive);
                Navigator.pushNamed(context, '/');
              },
            ),
            backgroundColor: const Color.fromARGB(222, 0, 183, 255),
            title: Text(
              'Setting',
              style: TextStyle(
                  fontFamily:
                      fontProvider.selectedFont == 'Inter' ? 'Inter' : 'Kalam',
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
                            fontFamily: fontProvider.selectedFont == 'Inter'
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
                                fontFamily: fontProvider.selectedFont == 'Inter'
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
                                fontFamily: fontProvider.selectedFont == 'Inter'
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
                          fontFamily: fontProvider.selectedFont == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
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
                                  fontFamily:
                                      fontProvider.selectedFont == 'Inter'
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
                          fontFamily: fontProvider.selectedFont == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
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
                        value: themeProvider.isDarkMode,
                        onChanged: (value) => themeProvider.changeTheme())
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
                                fontFamily: fontProvider.selectedFont == 'Inter'
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
                            fontFamily: fontProvider.selectedFont == 'Inter'
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
