import 'package:flutter/material.dart';
import 'package:itnew/Views/BottomNavi.dart';

class CaNhan extends StatefulWidget {
  const CaNhan({super.key});

  @override
  State<CaNhan> createState() => _CaNhanState();
}

class _CaNhanState extends State<CaNhan> {
  bool light = true;
  String status = 'Giao diện sáng';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: const Text(
          'Cá Nhân',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavi(index: 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  padding: const EdgeInsets.all(10),
                  child: const ClipOval(
                    child: Icon(
                      Icons.account_circle,
                      size: 130,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.black, // Màu của viền
                    ),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
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
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, '/daluu');
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Đã lưu',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons
                            .bookmark, // ------------------------------------------------- LƯU TIN TỨC --------------------------------
                        color: Colors.green,
                        size: 50,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, '/lichsu');
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Lịch sử',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons
                            .access_time_filled, // ---------------------------------------- LỊCH SỬ --------------------------------
                        color: Colors.green,
                        size: 50,
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
            const Row(
              children: [
                SizedBox(
                  width: 25,
                  height: 70,
                ),
                Text(
                  'Cài đặt',
                  style: TextStyle(
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
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushNamed(context, '/cochuvafontchu');
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.format_color_text_outlined,
                          size: 40,
                        ),
                        Text(
                          'Cỡ chữ & font chữ',
                          style: TextStyle(fontSize: 25),
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
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  width: 10,
                ),
                Switch(
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.black,
                    value: light,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                        status = value ? 'Giao diện sáng' : 'Giao diện tối';
                      });
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
                  child: const Row(
                    children: [
                      Text(
                        'Xoá tài khoản',
                        style: TextStyle(fontSize: 25),
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
                  child: const Text(
                    'Đăng Xuất',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
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
