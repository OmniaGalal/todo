import 'package:flutter/material.dart';
import 'package:todoapp/core/utilities/colors.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(

          margin: EdgeInsets.all(8),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.06,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue,


                  ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Play Basket Ball",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20,color: AppColor.primary),),
                    Text("10:05 AM  ")
                  ],
                ),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 2),
                 decoration: BoxDecoration(
                   color: AppColor.primary,
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: Icon(Icons.check,color: Colors.white,size:30 ,),
               )
               // ElevatedButton(onPressed: (){}, child: Icon(Icons.check))
              ],
            ),
          )
        ),
      ),
    );
  }
}
