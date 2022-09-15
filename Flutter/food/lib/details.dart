import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  const DetailsPage({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailsPage> createState() => DdetailsStatePage();
}

class DdetailsStatePage extends State<DetailsPage> {
  Map map = {};
  Map recmap = {};
  String name = "";
  String image = "";
  String diet = "";
  String prep_time = "";
  String ingredients_a = "";
  String instructions = "";
  String description = "";
  String course = "";
  String recname = "";
  String recimage = "";

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  void getDetails() async {
    try {
      var response = await Dio().post(
          'https://food-recommendation-ml.herokuapp.com/detail?name=' +
              widget.name.toString());
      map = Map.from(response.data);
      map.forEach((key, value) {
        Map va = value;
        switch (key) {
          case "name":
            name = va.values.toString();
            break;
          case "image_url":
            image = va.values.toString();
            break;
          case "description":
            description = va.values.toString();
            break;
          case "course":
            course = va.values.toString();
            break;
          case "diet":
            diet = va.values.toString();
            break;
          case "prep_time":
            prep_time = va.values.toString();
            break;
          case "ingredients_a":
            ingredients_a = va.values.toString();
            break;
          case "instructions":
            instructions = va.values.toString();
            break;
          default:
        }
      });
      getRecommendiation();
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  List rec = [];
  List rec_rec = [];
  void getRecommendiation() async {
    var reciperes;
    try {
      var recres = await Dio()
          .post("https://food-recommendation-ml.herokuapp.com/name?reciepe_name=" + widget.name)
          .then((value) async {
        rec.addAll(value.data);
        reciperes = await Dio()
            .post("https://food-recommendation-ml.herokuapp.com/recipe?reciepe_name=" + widget.name)
            .then((values) {
          rec_rec.addAll(values.data);
        });
      });
      print(rec[0]["name"]);
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food"),
        backgroundColor: Colors.blueGrey,
      ),
      body: name == ""
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            )
          : ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
                Text(
                  name.replaceAll("(", "").replaceAll(")", ""),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                    height: Get.height * .6,
                    child: Image(
                        image: NetworkImage(
                            image.replaceAll("(", "").replaceAll(")", "")),
                        fit: BoxFit.fitWidth)),
                SizedBox(height: 10),
                const Text(
                  "Description :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(description.replaceAll("(", "").replaceAll(")", "")),
                // SizedBox(height: 5),
                // Text(course.replaceAll("(", "").replaceAll(")", "")),
                // SizedBox(height: 5),
                // Text(diet.replaceAll("(", "").replaceAll(")", "")),
                SizedBox(height: 10),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Time :",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(prep_time.replaceAll("(", "").replaceAll(")", "")),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                const Text(
                  "Ingredients :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(ingredients_a.replaceAll("(", "").replaceAll(")", "")),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                const Text(
                  "Instructions :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(instructions.replaceAll("(", "").replaceAll(")", "")),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                const Text(
                  "similar :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                if (rec.length > 0) recommandation(rec),
                const Text(
                  "Recommendation :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                if (rec_rec.length > 0) recommandation(rec_rec),
              ],
            ),
    );
  }

  SizedBox recommandation(title) {
    return SizedBox(
      height: 700,
      child: AlignedGridView.count(
        crossAxisCount: Get.width < 600 ? 2 : 3,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        itemCount: title.length,
        itemBuilder: (context, index) {
          if (title[0] ==
              "Reciepe Not Found, run recipe_name api & try those name.") {
            return Text("No Data");
          }
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (a) => DetailsPage(
                            name: title[index]["name"]
                                .toString()
                                .replaceAll("(", "")
                                .replaceAll(")", ""),
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Get.width < 600 ? 200 : 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(title[index]["image_url"]
                            .toString()
                            .replaceAll("(", "")
                            .replaceAll(")", "")),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title[index]["name"]
                          .toString()
                          .replaceAll("(", "")
                          .replaceAll(")", ""),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
