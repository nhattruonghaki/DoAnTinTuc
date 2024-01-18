import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itnew/Models/FontChange.dart';
import 'package:itnew/Models/SaveArticle.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:itnew/Views/TrangChiTiet.dart';
import 'package:provider/provider.dart';

class DaLuu extends StatefulWidget {
  const DaLuu({Key? key});

  @override
  State<DaLuu> createState() => _DaLuuState();
}

class _DaLuuState extends State<DaLuu> {
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

  void _showLoginAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Bạn cần đăng nhập để thực hiện chức năng này.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      String userId = user?.uid ?? 'currentUserId';
      // Thực hiện các thao tác với user ở đây
    } else {
      _showLoginAlertDialog();
      // Xử lý khi user chưa được khởi tạo
    }

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
                'Saved',
                style: TextStyle(
                  fontFamily: fontProvider.selectedFont == 'Inter'
                      ? 'Inter'
                      : 'Kalam',
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ],
            ),
            body: FutureBuilder<List<Map<String, dynamic>>>(
future: SaveArticle().getSavedArticles(user?.uid ?? ""),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
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
                                        article['link']
                                            .toString()
                                            .substring(
                                                13,
                                                article['link']
                                                    .toString()
                                                    .indexOf('/', 13)),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article['date']
                                                .toString()
                                                .substring(
                                                    5,
                                                    min(30,
                                                        article['date']
                                                            .toString()
                                                            .length)),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            article['title']
                                                .toString()
                                                .substring(
                                                    5,
                                                    min(30,
                                                        article['title']
                                                            .toString()
                                                            .length)),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
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
        },
      ),
    );
  }
}
