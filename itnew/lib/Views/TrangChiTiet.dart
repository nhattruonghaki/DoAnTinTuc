import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itnew/Models/FontChange.dart';
import 'package:itnew/Models/SaveArticle.dart';
import 'package:itnew/ViewModels/News.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';

class TrangChiTiet extends StatefulWidget {
  final title;
  final imagedata;
  final description;
  final date;
  final link;

  const TrangChiTiet({
    super.key,
    required this.title,
    required this.imagedata,
    required this.description,
    required this.date,
    required this.link,
  });

  @override
  State<TrangChiTiet> createState() => _TrangChiTietState();
}

class _TrangChiTietState extends State<TrangChiTiet> {
  late User? user = FirebaseAuth.instance.currentUser;
  bool isArticleSaved = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  // late QuerySnapshot _newsSnapshot;

  // Hàm để lắng nghe sự kiện thay đổi
// void _listenForNewsChanges() {
//   _firestore
//       .collection('users')
//       .doc(userId)
//       .collection('saved_articles')
//       //.orderBy('timestamp', descending: true)
//       .snapshots()
//       .listen((QuerySnapshot snapshot) {
//     setState(() {
//       _newsSnapshot = snapshot;
//     });
//   });
// }


// // Hàm để lấy tin đã lưu mới nhất
//   Map<String, dynamic>? _getLatestSavedNews() {
//     if (_newsSnapshot.docs.isNotEmpty) {
//       final latestSavedNewsDoc = _newsSnapshot.docs.first;
//       return latestSavedNewsDoc.data() as Map<String, dynamic>;
//     }
//     return null;
//   }

//   // Hàm để xoá tin tức mới nhất
//   Future<void> _removeLatestNews() async {
//     final latestNews = _getLatestSavedNews();
//     try {
//       if (latestNews != null) {
//         // Lấy danh sách tất cả các tài liệu trong bộ sưu tập 'saved_articles'
//         final savedArticlesCollection = _firestore
//             .collection('users')
//             .doc(userId)
//             .collection('saved_articles');
//         final allSavedArticles = await savedArticlesCollection.get();

//         // Lặp qua từng tài liệu và kiểm tra xem nó có phải là tài liệu cần xoá không
//         for (final doc in allSavedArticles.docs) {
//           final data = doc.data();
//           if (data['newsId'] == latestNews['newsId']) {
//             await savedArticlesCollection.doc(doc.id).delete();
//             print('Đã xoá tin tức mới nhất ${latestNews['newsId']}');
//             return;
//           }
//         }

//         // Không tìm thấy tài liệu cần xoá
//         print('Không có tin tức nào để xoá.');
//       } else {
//         print('Không có tin tức nào để xoá.');
//       }
//     } catch (e) {
//       print('Lỗi.$e');
//     }
//   }

void _showSnackBar(String mess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mess),
      duration: const Duration(seconds: 1),
    ),
  );
}



  @override
  void initState() {
super.initState();
    //userId = user!.uid;
    // _listenForNewsChanges();
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
            backgroundColor:
                themeProvider.isDarkMode ? Colors.black : Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(222, 0, 183, 255),
              title: Text(
                'ITFEEDS',
                style: TextStyle(
                  fontFamily:
                      fontProvider.selectedFont == 'Inter' ? 'Inter' : 'Kalam',
                  color: Colors.white,
                ),
              ),
              
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                IconButton(
                  onPressed: () async {
                    try {
                      String userId = user!.uid;
                      Map<String, dynamic> articleData = {
                        'title': widget.title,
                        'imagedata': widget.imagedata,
                        'description': widget.description,
                        'date': widget.date,
                        'link': widget.link,
                      };


                      print('mã tài khoản: $userId');
                        print('lưu thành công');
                        await SaveArticle().saveArticle(userId, articleData);
                        _showSnackBar('Đã lưu tin tức vào danh sách');


                      setState(() {
                        isArticleSaved = !isArticleSaved;
                        
                      });
                    } catch (e) {
                      print('Lỗi: $e');
                    }
                  },
                  icon: Icon(
                    isArticleSaved ? Icons.bookmark : Icons.bookmark_outline,
                    color: isArticleSaved ? Colors.yellow : Colors.black,
size: 40,
                  ),
                )
              ],
            ),
            body: ListView(
              children: [
                Image.network(
                  widget.imagedata ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title ?? '',
                        style: TextStyle(
                          fontFamily: fontProvider.selectedFont == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
                          fontWeight: FontWeight.w500,
                          fontSize: fontProvider.fontSize.toDouble(),
                          color: textColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          widget.date.toString().substring(5, 34),
                          style: TextStyle(
                            fontFamily: fontProvider.selectedFont == 'Inter'
                                ? 'Inter'
                                : 'Kalam',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: textColor,
                          ),
                        ),
                      ),
                      Text(
                        (widget.description != null &&
                                widget.description.toString().contains('<div>'))
                            ? (() {
                                String noidung = widget.description.toString();
                                int startDivIndex = noidung.indexOf(
                                    '<div>', noidung.indexOf('<div>') + 1);
                                int endDivIndex =
                                    noidung.indexOf('</div>', startDivIndex);
                                String contentdescription = noidung.substring(
                                    startDivIndex + 5, endDivIndex);
                                return contentdescription;
                              })()
                            : 'Không có mô tả hoặc mô tả không hợp lệ',
                        style: TextStyle(
                          fontFamily: fontProvider.selectedFont == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsWebView(
                          url: widget.link.toString().substring(
                              5, widget.link.toString().indexOf('}', 5)),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Xem chi tiết >>>",
                      style: TextStyle(
                        fontFamily: fontProvider.selectedFont == 'Inter'
                            ? 'Inter'
                            : 'Kalam',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



                      // if (isArticleSaved) {
                      //   final latestNews = _getLatestSavedNews();
                      //   if (latestNews != null) {
                      //     print('XOÁ thành công');
                      //     await _removeLatestNews();
                      //     _showSnackBar('Đã xoá tin tức khỏi danh sách');
                      //   }
                      // } else {
                      //   // Code để lưu tin tức
                      //   // Tin tức chưa được lưu, lưu nó

                      //   print('lưu thành công');
                      //   await SaveArticle().saveArticle(userId, articleData);
                      //   _showSnackBar('Đã lưu tin tức vào danh sách');
                      // }