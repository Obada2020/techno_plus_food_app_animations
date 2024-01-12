import 'package:flutter/material.dart';
import 'package:food_app_animations/config/colors.dart';
import 'package:food_app_animations/config/mock.dart';
import 'package:food_app_animations/config/scroll_config.dart';
import 'package:food_app_animations/food_details.page.dart';
import 'package:food_app_animations/widgets/food.widget.dart';

class MostPopularListWidget extends StatefulWidget {
  const MostPopularListWidget({super.key});

  @override
  State<MostPopularListWidget> createState() => _MostPopularListWidgetState();
}

class _MostPopularListWidgetState extends State<MostPopularListWidget>
    with SingleTickerProviderStateMixin {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        PageController(viewportFraction: 0.7, initialPage: _currentPage);
    _controller.addListener(_changePage);
  }

  void _changePage() {
    setState(() {
      _currentPage = _controller.page!.round();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_changePage);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Most",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.w700)),
              Text("Popular Food",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        Expanded(
          child: PageView.builder(
            scrollBehavior: WindowsScrollBehaviour(),
            clipBehavior: Clip.none,
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            itemCount: kPastas.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return DetailsPage(
                          food: kPastas[index],
                          introAnimation: animation,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: FoodWidget(
                  food: kPastas[index],
                  active: _currentPage == index,
                ),
              ),
            ),
            padEnds: false,
          ),
        ),
        const SizedBox(height: kDefaultPadding)
      ],
    );
  }
}
