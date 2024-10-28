import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexBook extends StatefulWidget {
  const IndexBook({Key? key}) : super(key: key);

  @override
  _IndexBookState createState() => _IndexBookState();
}

class _IndexBookState extends State<IndexBook> {
  // 卡片数据
  final List<Map<String, String>> cards = [
    {
      "image": "assets/image/book/custom_search.png",
      "text": "Custom Search Page",
      "description": "Custom Search Web Page.",
      "url": "https://shadowplusing.website/custom_search_page/",
    },
    {
      "image": "assets/image/book/sub_font.png",
      "text": "SubFont Package",
      "description": "Compress the size of the font package.",
      "url": "https://github.com/shAdow-XJY/subFontPackage",
    },
    {
      "image": "assets/image/book/writing_writer.jpg",
      "text": "Writing Writer",
      "description": "A write application developed and used myself with local storage.",
      "url": "https://github.com/shAdow-XJY/writing_wirter",
    },
    {
      "image": "assets/image/book/back_end.png",
      "text": "Backend Service",
      "description": "A simple local backend service and debug front web.",
      "url": "https://github.com/shAdow-XJY/backend_service",
    },
    {
      "image": "assets/image/book/novel_read.png",
      "text": "Novel Read",
      "description": "A simple web read page. (doing...)",
      "url": "https://shadowplusing.website/novel_read/",
    },
  ];

  // 初始化一个变量来存储当前选中的卡片内容
  String selectedContent = "Custom Search Page";
  String selectedDescription =
  '''
Custom Search Web Page.
  ''';

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
            child: Stack(
              children: [
                Container(
                  width: double.infinity, // 确保在水平方向上占满宽度
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    image: DecorationImage(
                      image: AssetImage(
                        cards.firstWhere((card) => card["text"] == selectedContent)["image"]!,
                      ),
                      fit: BoxFit.contain,
                      alignment: Alignment.centerRight,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16), // 标题的内边距
                        child: Text(
                          selectedContent,
                          style: const TextStyle(
                            fontSize: 20, // 标题字体大小
                            fontWeight: FontWeight.bold, // 加粗标题
                            color: Colors.white, // 标题颜色
                          ),
                          textAlign: TextAlign.center, // 标题居中对齐
                        ),
                      ),
                      const Divider(color: Colors.grey), // 分隔线
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16), // 内容内边距
                            child: Text(
                              selectedDescription,
                              style: const TextStyle(
                                fontSize: 16, // 描述字体大小
                                color: Colors.grey, // 描述颜色
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16, // 图标按钮距离顶部的距离
                  left: 16, // 图标按钮距离左边的距离
                  child: IconButton(
                    icon: const Icon(Icons.troubleshoot, color: Colors.blue), // 图标和颜色
                    onPressed: () {
                      // 点击事件：跳转到指定网页
                      final url = cards.firstWhere((card) => card["text"] == selectedContent)["url"];
                      launchUrl(Uri.parse(url ?? ""));
                    },
                  ),
                ),
              ],
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
