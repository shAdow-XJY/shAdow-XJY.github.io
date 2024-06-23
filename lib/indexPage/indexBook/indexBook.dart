import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class IndexBook extends StatefulWidget {
  const IndexBook({Key? key}) : super(key: key);

  @override
  _IndexBookState createState() => _IndexBookState();
}

class _IndexBookState extends State<IndexBook> {
  // 初始化一个变量来存储当前选中的卡片内容
  String selectedContent = 'Book 1';
  String selectedDescription = '''
  Book 1 introduction.
  ''';

  // 卡片数据
  List<Map<String, String>> cards = [
    {
      "image": "assets/image/book/book.jpg",
      "text": "Book 1",
      "description": "Book 1 introduction."
    },
    {
      "image": "assets/image/book/book_website.jpg",
      "text": "Novel Website ...",
      "description": "Novel Website introduction."
    },
  ];

  // 添加一个用于追踪拖动的变量
  double _startDragX = 0.0;
  double _currentDragX = 0.0;
  final ScrollController _scrollController = ScrollController();

  // 开始拖动的处理函数
  void _onHorizontalDragStart(DragStartDetails details) {
    _startDragX = details.globalPosition.dx;
    _currentDragX = _scrollController.offset;
  }

  // 更新拖动的处理函数
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    double delta = details.globalPosition.dx - _startDragX;
    _scrollController.jumpTo(_currentDragX - delta);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.canvasColor,
      ),
      child: Column(
        children: [
          const Spacer(flex: 1), // 10% 空白
          Expanded(
            flex: 6, // 60% 竖直ScrollView
            child: Container(
              width: double.infinity, // 确保在水平方向上占满宽度
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                  image: AssetImage(
                    cards.firstWhere((card) => card["text"] == selectedContent)["image"]!,
                  ),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.dstATop
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity, // 同样确保在水平方向上占满宽度
                  padding: const EdgeInsets.all(16), // 添加内边距
                  child: Text(
                    selectedDescription,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(flex: 1), // 5% 空白

          Expanded(
            flex: 5,
            child: GestureDetector(
              onHorizontalDragStart: _onHorizontalDragStart,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  bool isSelected = cards[index]["text"] == selectedContent;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedContent = cards[index]["text"]!;
                        selectedDescription = cards[index]["description"]!;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: double.infinity,
                          width: 100, // 设置卡片的固定宽度
                          // padding: EdgeInsets.all(8), // 添加一些内边距
                          margin: const EdgeInsets.only(top: 28), // 为顶部箭头留出空间
                          decoration: BoxDecoration(
                            border: isSelected ? Border.all(color: theme.colorScheme.secondary, width: 3) : null, // 粗大的边框
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 卡片圆角
                            ),
                            elevation: isSelected ? 10 : 5, // 选中时阴影更大
                            color: isSelected ? theme.colorScheme.secondary.withOpacity(0.5) : theme.cardColor, // 改变背景色
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  child: Image.asset(
                                    cards[index]["image"]!,
                                    height: 50, // 图片高度
                                    // width: double.infinity, // 图片宽度
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: AutoSizeText(
                                    cards[index]["text"]!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : theme.textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isSelected) Positioned(
                          top: 0,
                          child: Icon(Icons.arrow_drop_up, size: 50, color: theme.colorScheme.secondary), // 大箭头指向上方
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const Spacer(flex: 1), // 5% 空白
        ],
      ),
    );
  }
}
