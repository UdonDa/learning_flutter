import 'package:flutter/material.dart';




class ExploreCard extends StatelessWidget {

  String titleText;
  List<String> itemList;
  ExploreCard({this.itemList, this.titleText});


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: SizedBox(
        height: 250.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              titleText,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(fontSize: 25.0)),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) => SizedBox(
                    height: 80.0,
                    width: 300.0,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(itemList[index], fit: BoxFit.cover,),
                      ),
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}