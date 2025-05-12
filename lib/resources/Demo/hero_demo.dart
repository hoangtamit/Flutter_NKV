import 'package:flutter/material.dart';

// Màn hình chính: Hiển thị danh sách hình ảnh trong ListView
class HomeScreen_ListView extends StatelessWidget {
  const HomeScreen_ListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Demo - Home'),
        centerTitle: true,
      ),
      body: ListView.builder(
        // ListView.builder: Hiển thị danh sách cuộn với các hình ảnh
        // Thuộc tính:
        // - itemCount: Số lượng mục
        // - itemBuilder: Xây dựng từng mục
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                // Điều hướng sang DetailScreen, truyền chỉ số để dùng cùng tag
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(imageIndex: index),
                  ),
                );
              },
              child: Hero(
                // Hero: Tạo hiệu ứng chuyển tiếp cho hình ảnh
                // Thuộc tính:
                // - tag: Định danh duy nhất để liên kết với Hero ở DetailScreen
                // - child: Widget con (hình ảnh) được chuyển tiếp
                tag: 'image-hero-$index',
                child: Image.network(
                  'https://picsum.photos/200?image=$index',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error,
                    size: 50,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Màn hình chính: Hiển thị lưới hình ảnh trong GridView
class HomeScreen_GridView extends StatelessWidget {
  const HomeScreen_GridView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero with GridView Demo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // GridView.builder: Hiển thị lưới 3 cột với các hình ảnh
          // Thuộc tính:
          // - gridDelegate: Cấu hình lưới (số cột, khoảng cách, tỷ lệ)
          // - physics: Vô hiệu hóa cuộn để vừa với Container
          // - shrinkWrap: Đảm bảo GridView điều chỉnh theo nội dung
          // - itemCount, itemBuilder: Xây dựng các mục
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 600, // Chiều cao đủ để hiển thị lưới
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 cột
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1, // Tỷ lệ vuông cho các ô
              ),
              //physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn
              shrinkWrap: true, // Điều chỉnh theo nội dung
              itemCount: 50,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Điều hướng sang DetailScreen, truyền chỉ số để dùng cùng tag
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(imageIndex: index),
                      ),
                    );
                  },
                  child: Hero(
                    // Hero: Tạo hiệu ứng chuyển tiếp cho hình ảnh
                    // Thuộc tính:
                    // - tag: Định danh duy nhất để liên kết với Hero ở DetailScreen
                    // - child: Hình ảnh trong ô lưới
                    tag: 'image-hero-$index',
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network(
                        'https://picsum.photos/250?image=$index',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.error,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Màn hình chi tiết: Hiển thị hình ảnh lớn hơn
class DetailScreen extends StatelessWidget {
  final int imageIndex;

  const DetailScreen({super.key, required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Demo - Detail'),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          // Hero: Liên kết với Hero ở HomeScreen qua cùng tag
          // Thuộc tính:
          // - tag: Phải khớp với tag ở HomeScreen
          // - child: Hình ảnh lớn hơn
          tag: 'image-hero-$imageIndex',
          child: Image.network(
            'https://picsum.photos/400?image=$imageIndex',
            width: 400,
            height: 400,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}





