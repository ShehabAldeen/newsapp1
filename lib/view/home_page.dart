import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:newsapi/controller/news_controller.dart';
import 'package:newsapi/model/news_model.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsController controller=Get.put(NewsController());
  int currentIndex=0;

  List<String> categoryList=[
    'sports',
    'science',
    'health',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News today'),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Colors.white),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          selectedItemColor: Colors.red,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: 'sports',),
            BottomNavigationBarItem(
                icon: Icon(Icons.science),
                label: 'science'),
            BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety),
                label: 'health'),

          ],
        ),
      ),
      body: FutureBuilder(
        future:controller.getDate(categoryList[currentIndex]) ,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Articles data=snapshot.data;
          if(snapshot.hasData) {
            return ListView.builder(itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height *0.3,
                      child: Image.network(data.articles?.elementAt(index).
                      urlToImage.toString()?? " ",fit: BoxFit.fill,),
                    ),
                    Text(data.articles?.elementAt(index).title ??" ",
                      style: TextStyle(fontSize: 15,color: Colors.grey[800],),
                      textDirection: TextDirection.rtl,),
                    Text(data.articles?.elementAt(index).description ??" ",
                      style: TextStyle(fontSize: 15,color: Colors.grey,),
                      textDirection: TextDirection.rtl,)


                  ],
                ),
              );
            }, itemCount: data.articles?.length?? 0,);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },

      ),
    );
  }

}