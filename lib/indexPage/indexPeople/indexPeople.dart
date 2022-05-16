import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class IndexPeople extends StatefulWidget {
  const IndexPeople({Key? key}) : super(key: key);

  @override
  _IndexPeopleState createState() => _IndexPeopleState();
}


class _IndexPeopleState extends State<IndexPeople> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.canvasColor,
      ),
      child: Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/image/avatar.jpg'),
                  ),
                ),
              ),
            ],
          ),
          AutoSizeText(
            'ShadowPlus',
            minFontSize: 10.0,
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                shadows: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.white.withOpacity(0.54)),
                ]),
          ),

        ]
      ),
    );
  }
}