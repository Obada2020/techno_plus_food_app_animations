import 'package:flutter/material.dart';
import 'package:food_app_animations/config/colors.dart';
import 'package:food_app_animations/widgets/most_popular_list.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 63, 114),
        elevation: 0,
        title: const Text("Techno Plus"),
      ),
      backgroundColor: kGray,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        border: InputBorder.none,
                        hintText: 'Search'),
                  ),
                ),
                Expanded(child: MostPopularListWidget()),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
