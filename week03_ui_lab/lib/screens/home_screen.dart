import 'package:flutter/material.dart';
import '../widgets/item_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // รายการสินค้าตัวอย่างของแอป Green Market
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'ผักสลัดออร์แกนิก',
      'subtitle': 'สดใหม่จากฟาร์ม • ฿45 / กิโลกรัม',
      'icon': Icons.eco,
    },
    {
      'title': 'สตรอว์เบอร์รีสด',
      'subtitle': 'หวานกรอบ เกรดพรีเมียม • ฿120 / กล่อง',
      'icon': Icons.shopping_basket,
    },
    {
      'title': 'กล้วยหอมทอง',
      'subtitle': 'อุดมด้วยวิตามิน • ฿35 / หวี',
      'icon': Icons.lightbulb_outline,
    },
    {
      'title': 'มะเขือเทศเชอร์รี',
      'subtitle': 'ปลอดสารเคมี 100% • ฿50 / ถุง',
      'icon': Icons.local_florist,
    },
  ];

  // เรียกเมื่อกด item ใน Bottom Navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // อัปเดต index แล้วสั่งให้ build ใหม่
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Green Market',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              'Dev by ชนินทร์', // <-- แก้ตรงนี้เป็นชื่อของคุณ
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
    ],
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
      tooltip: 'ค้นหาสินค้า',
    ),
  ],
),
      // ---- แก้จุดนี้: เรียก _buildBody() แทนการผูก ListView ตายตัว ----
      body: _buildBody(),
      // ทำให้ FAB แสดงเฉพาะหน้าหลัก (tab 0) จะได้ดูเป็นธรรมชาติขึ้น
      // (ถ้าอยากให้แสดงทุก tab เหมือนเดิม ลบเงื่อนไข if ออกแล้วคง FAB ไว้ตรงๆ ได้)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('เปิดหน้าเพิ่มสินค้าใหม่'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('เพิ่มสินค้า'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'ค้นหา',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }

  // ---- ฟังก์ชันใหม่: สลับเนื้อหาตาม tab ที่เลือก ----
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildProductList();
      case 1:
        return const Center(
          child: Text('หน้าค้นหา (อยู่ระหว่างพัฒนา)'),
        );
      case 2:
        return const Center(
          child: Text('หน้าโปรไฟล์ (อยู่ระหว่างพัฒนา)'),
        );
      default:
        return _buildProductList();
    }
  }

  // ---- ย้าย ListView.builder เดิมมาไว้ในฟังก์ชันนี้ ----
  Widget _buildProductList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return ItemCard(
          title: item['title'],
          subtitle: item['subtitle'],
          icon: item['icon'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  title: item['title'],
                  subtitle: item['subtitle'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}