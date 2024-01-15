import 'package:flutter/material.dart';

class TimKiem extends StatefulWidget {
  const TimKiem({super.key});

  @override
  State<TimKiem> createState() => _TimKiemState();
}

class _TimKiemState extends State<TimKiem> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.search,
          color: Colors.black,
          size: 50,),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Tìm kiếm",
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  _searchController.clear();
                },
                icon: Icon(Icons.clear,color: Colors.black,))
            ],
                ),
              ),
              centerTitle: true,
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }, 
                child: const Text("Đóng",
                      style: TextStyle(color: Colors.black, fontSize: 20),))
              ],),
    );
  }
}
