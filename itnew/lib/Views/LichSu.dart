import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/FontChange.dart';
import 'package:itnew/Models/SaveArticle.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:itnew/Views/TrangChiTiet.dart';
import 'package:provider/provider.dart';

class LichSu extends StatefulWidget {
  const LichSu({super.key});

  @override
  State<LichSu> createState() => _LichSuState();
}

class _LichSuState extends State<LichSu> {
  late User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        user = newUser;
      });
    });
  }

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
          backgroundColor: themeProvider.isDarkMode
              ? const Color.fromARGB(255, 24, 24, 24)
              : Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(222, 0, 183, 255),
            title: Text(
              'History',
              style: TextStyle(
                  fontFamily:
                      fontProvider.selectedFont == 'Inter' ? 'Inter' : 'Kalam',
                  color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm deletion'),
                          content: const Text(
                              'Are you sure you want to delete your history?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Đóng hộp thoại
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                String userId = user!.uid;
                                await SaveArticle()
                                    .removeAllHistorySavedArticles(userId);
                                Navigator.of(context).pop(); // Đóng hộp thoại
                                // Load lại trang
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LichSu()),
                                );
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.black, size: 40))
            ],
          ),
          body: FutureBuilder<List<Map<String, dynamic>>>(
            future: SaveArticle().getHistorySavedArticles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Map<String, dynamic>> savedArticles = snapshot.data ?? [];

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: savedArticles.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> article = savedArticles[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return TrangChiTiet(
                                        title: article['title'],
                                        imagedata: article['imagedata'],
                                        description: article['description'],
                                        date: article['date'],
                                        link: article['link'],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: article['imagedata'] != null
                                        ? Image.network(
                                            article['imagedata'],
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.grey),
                                    title: Text(
                                      article['link'].toString().substring(
                                          13,
                                          article['link']
                                              .toString()
                                              .indexOf('/', 13)),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily:
                                              fontProvider.selectedFont ==
                                                      'Inter'
                                                  ? 'Inter'
                                                  : 'Kalam',
                                          fontWeight: FontWeight.bold,
                                          color: textColor),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article['date'].toString().substring(
                                              5,
                                              min(
                                                  30,
                                                  article['date']
                                                      .toString()
                                                      .length)),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily:
                                                fontProvider.selectedFont ==
                                                        'Inter'
                                                    ? 'Inter'
                                                    : 'Kalam',
                                            color: textColor,
                                          ),
                                        ),
                                        Text(
                                          article['title'].toString().substring(
                                              5,
                                              min(
                                                  30,
                                                  article['title']
                                                      .toString()
                                                      .length)),
                                          style: TextStyle(
                                              fontSize: fontProvider.fontSize,
                                              fontFamily:
                                                  fontProvider.selectedFont ==
                                                          'Inter'
                                                      ? 'Inter'
                                                      : 'Kalam',
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
