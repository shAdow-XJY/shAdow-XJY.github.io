import 'package:flutter/material.dart';

class ListBuilder extends StatefulWidget {
  bool oneLevel;
  List<Map<String, String>> levelObj;
  double? itemHeight;
  Function(String selectedTitle)? onPressed;

  ListBuilder({
    Key? key,
    required this.oneLevel,
    required this.levelObj,
    this.itemHeight = 100,
    this.onPressed,
  }) : super(key: key);

  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: widget.levelObj.length,
      itemBuilder: (context, index) => Container(
          height: widget.itemHeight,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.canvasColor,
            boxShadow: const [BoxShadow()],
          ),
          child: widget.oneLevel
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(widget.levelObj[index]
                                      ['image'] ??
                                  'assets/icon/repositories.png'),
                            ),
                          ),
                        ),
                        InkWell(
                          child:Text(
                            widget.levelObj[index]['title'] ?? 'default',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.white.withOpacity(0.54)),
                                ]),
                          ),
                          onTap: (){
                            widget.onPressed!(
                                widget.levelObj[index]['title'] ?? 'default');
                          },
                        )
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_right),
                      iconSize: 48,
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        widget.onPressed!(
                            widget.levelObj[index]['title'] ?? 'default');
                      },
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Text(
                        widget.levelObj[index]['title'] ?? 'default',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.white.withOpacity(0.54)),
                            ]),
                      ),
                      onTap: () {
                        widget.onPressed!(
                            widget.levelObj[index]['title'] ?? 'default');
                      },
                    ),
                  ],
                )),
    );
  }
}
