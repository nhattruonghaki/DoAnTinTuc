import 'package:flutter/material.dart';
import 'package:itnew/Models/FontsChu.dart';
import 'package:itnew/Models/ThemeProvider.dart';
import 'package:provider/provider.dart';

class TimKiem extends StatefulWidget {
  const TimKiem({super.key});

  @override
  State<TimKiem> createState() => _TimKiemState();
}

class _TimKiemState extends State<TimKiem> {
  FontsChu fontsChu = FontsChu();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color.fromARGB(255, 24, 24, 24)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        leading: const Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(
              Icons.search,
              color: Colors.black,
              size: 40,
            )
          ],
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? const Color.fromARGB(255, 24, 24, 24)
                : Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(
                    fontFamily:
                        fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                    color: themeProvider.isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 24, 24, 24),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Tìm kiếm",
                    hintStyle: TextStyle(
                        fontFamily:
                            fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                        color: Colors.grey),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    _searchController.clear();
                  },
                  icon: Icon(
                    Icons.clear,
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ))
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                "Đóng",
                style: TextStyle(
                    fontFamily:
                        fontsChu.fontInter == 'Inter' ? 'Inter' : 'Kalam',
                    color: Colors.black,
                    fontSize: 20),
              ))
        ],
      ),
    );
  }
}
