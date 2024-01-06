import 'package:flutter/material.dart';
import 'package:itnew/Views/BottomNavi.dart';
import 'package:itnew/Views/TimKiem.dart';
import 'package:itnew/Views/TrangThongBao.dart';

class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu>
    with SingleTickerProviderStateMixin {
  // minxin cung cấp đối tượng đối tượng TickerProvider
// duy nhất và có thể sử dụng cho 1 Ticker (đối tượng thời gian) -> animation
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //return DefaultTabController(
    //  length: 2,
    //child:
    return Scaffold(
// ----------------------------------------------- LOGO -----------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 0, 183, 255),
        title: const Text(
          'ITNew Internet Society',
          style: TextStyle(
            //fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimKiem(),
                    ));
              },
              icon: const Icon(
                Icons
                    .search, // ------------------------------------- TÌM KIẾM ------------------------
                color: Colors.black,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrangThongBao()),
                );
              },
              icon: const Icon(
                Icons
                    .notifications_outlined, // ------------------------------------- THÔNG BÁO ------------------------
                color: Colors.black,
                size: 30.0,
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(40), // kích thước tối ưu cho TabBar
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black, // unfocus

              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flash_on_sharp),
                      SizedBox(width: 1),
                      Text('Mới nhất')
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up_outlined),
                      SizedBox(width: 1),
                      Text('Xu hướng')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
// ----------------------------------------------- DANH MỤC -------------------------------------------
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(222, 0, 183, 255)),
                child: Image.asset('assets/ITNew.png')),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(0); // hiệu ứng chuyển đến tab "Mới nhất"
              },
              leading: const Icon(Icons.flash_on_sharp),
              title: const Text('Mới nhất'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _tabController
                    ?.animateTo(1); // hiệu ứng chuyển đến tab "Xu hướng"
              },
              leading: const Icon(Icons.trending_up_outlined),
              title: const Text('Xu hướng'),
            ),
          ],
        ),
      ),
// -------------------------------------------- FOOTER -----------------------------------------------------------------------------
      bottomNavigationBar: const BottomNavi(index: 0),
      
// -------------------------------------------- BODY --------TAB BAR VIEW ----------------------------------------------------------
body: TabBarView(
  controller: _tabController,
  children: [
  Column(
    
    children: [
      GestureDetector(
        onTap: (){
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/trangchitiet');
        },
        child: Text('hãy chọn trang chi tiết'),
      )
    ],
  ),
   Column(
    
    children: [
      GestureDetector(
        onTap: (){
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, '/trangchitiet');
        },
        child: Text('hãy chọn trang chi tiết'),
      )
    ],
  ),
]),
    );
    //);
  }
}
