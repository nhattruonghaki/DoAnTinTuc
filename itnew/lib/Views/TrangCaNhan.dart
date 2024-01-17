import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Models/ThemeProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaNhan extends StatefulWidget {
  const CaNhan({super.key});

  @override
  State<CaNhan> createState() => _CaNhanState();
}

class _CaNhanState extends State<CaNhan> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  
  FontsChu fontsChu = FontsChu();
  bool light = false;

  String status = 'Giao diện tối';
  String userName = '';
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo trạng thái đăng nhập từ SharedPreferences khi widget được tạo ra
    _loadUserLoginStatus();
  }

  // Hàm để lấy trạng thái đăng nhập từ SharedPreferences
  void _loadUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String savedUserName = prefs.getString('userName') ?? '';

    setState(() {
      isUserLoggedIn = isLoggedIn;
      userName = savedUserName;
    });
  }

  // Hàm để lưu trạng thái đăng nhập vào SharedPreferences
  void _saveUserLoginStatus(bool isLoggedIn, String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
    prefs.setString('userName', userName);
  }

  void _showLoginAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yêu cầu đăng nhập'),
          content: Text('Vui lòng đăng nhập để sử dụng chức năng này.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
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
    var themeProvider = Provider.of<ThemeProvider>(context);

    Color scaffoldBackgroundColor = themeProvider.isDarkMode
        ? const Color.fromARGB(255, 24, 24, 24)
        : Colors.white;
    Color textColor = themeProvider.isDarkMode
        ? Colors.white
        : const Color.fromARGB(255, 24, 24, 24);

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: Text(
          'Cá nhân',
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
                isUserLoggedIn
                    ? Text(
                        userName,
                        style: TextStyle(
                          fontFamily: fontsChu.fontInter == 'Inter'
                              ? 'Inter'
                              : 'Kalam',
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    :
                ElevatedButton(
                  onPressed: () async {
                    try {
                        // Đăng xuất tài khoản Google hiện tại (nếu có)
                        await _googleSignIn.signOut();

                        // Đăng nhập với tài khoản Google mới
                        GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                        if (googleUser == null) {
                          // Người dùng hủy đăng nhập hoặc không chọn tài khoản
                          return;
                        }

                        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                        AuthCredential credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken,
                        );

                        UserCredential authResult = await _auth.signInWithCredential(credential);
                        User? user = authResult.user;

                        if (user != null) {
                          setState(() {
                            userName = user.displayName ?? '';
                            isUserLoggedIn = true;
                          });
                          _saveUserLoginStatus(true, userName);
                        }
                      } catch (error) {
                        print('Error signing in with Google: $error');
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: textColor, // Màu của viền
                    ),
                  ),
                  child: Text(
                    'Đăng nhập', // --------------------------------------------------- ĐĂNG NHẬP ----------------------------------
                    style: TextStyle(
                        fontFamily:
                            fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
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
                      Text(
                        'Đã lưu',
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
                      Text(
                        'Lịch sử',
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
                  'Cài đặt',
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
                      Navigator.popUntil(context, (route) => route.isCurrent);
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
                          'Cỡ chữ & font chữ',
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
                    value: themeProvider.isDarkMode,
                    onChanged: (bool value) {
                      themeProvider.toggleTheme();
                    })
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
                        'Xoá tài khoản',
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
                  onPressed: () async {
                    try {
                      if (isUserLoggedIn) {
                        // Đăng xuất
                        await _auth.signOut();
                        setState(() {
                          userName = '';
                          isUserLoggedIn = false;
                        });
                      } else {
                        _showLoginAlertDialog();
                      }
                    } catch (error) {
                      print('Error signing in/out with Google: $error');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.black, // Màu của viền
                    ),
                  ),
                  child: Text(
                    'Đăng Xuất',
                    style: TextStyle(
                        fontFamily:
                            fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
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
  }
}
