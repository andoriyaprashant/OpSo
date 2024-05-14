import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget getProjectCard(BuildContext context,String projectName, String projectRepoLink, List<String> projectTags, String projectOwner){

  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      children: [
        Text(projectName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(projectOwner,style: TextStyle(fontSize: 15,color: Colors.black),),
        ),
        Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: projectTags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(projectTags[index]+",",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black),),
                );
            }),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: (){

              },
              child: Text("Go to Repository")
          ),
        )
      ],
    ),
  );
}