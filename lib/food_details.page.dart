import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_animations/config/colors.dart';
import 'models/food.model.dart';

class DetailsPage extends StatefulWidget {
  final DishModel food;
  final Animation<double> introAnimation;
  const DetailsPage({
    super.key,
    required this.food,
    required this.introAnimation,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  //
  late final AnimationController _showPageController;
  late final AnimationController _rotateAnimation;
  //
  @override
  void initState() {
    super.initState();
    _showPageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    //
    _rotateAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    widget.introAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _showPageController.forward();
          _rotateAnimation.repeat();
        }
      },
    );
  }

  @override
  void dispose() {
    _rotateAnimation.dispose();
    _showPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: FadeTransition(
          opacity: _showPageController,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(
              CurvedAnimation(
                parent: _showPageController,
                curve: const Interval(0, .5, curve: Curves.easeOut),
              ),
            ),
            child: IconButton(
              icon: const Icon(CupertinoIcons.chevron_left, color: kWhite),
              onPressed: () {
                _showPageController
                    .reverse()
                    .then((value) => Navigator.of(context).pop());
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Hero(
            tag: "OB${widget.food.id}",
            child: Container(
              transform: Matrix4.identity()..scale(1.15),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: kFoodColors[int.parse(widget.food.id) - 1],
                borderRadius: BorderRadius.circular(kDefaultPadding * 2),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    // ..._sideImage(),
                    Align(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: "plate${widget.food.id}",
                        child: Container(
                          transform: Matrix4.identity()..scale(2.0),
                          transformAlignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(.5),
                                blurRadius: 30,
                                offset: const Offset(
                                    0,
                                    kDefaultPadding +
                                        5), // chaxnges position of shadow
                              ),
                            ],
                          ),
                          child: AnimatedBuilder(
                            animation: _rotateAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: Tween<double>(begin: 0, end: 2 * pi)
                                    .animate(_rotateAnimation)
                                    .value,
                                child: child,
                              );
                            },
                            child: Image.asset(
                              "assets/images/pasta/plate${widget.food.id}.png",
                              height: kDefaultPadding * 7,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: AnimatedBuilder(
                  animation: _showPageController,
                  builder: (context, child) {
                    return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(0, 1), end: Offset.zero)
                            .animate(_showPageController),
                        child: child);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                          color: kBlack.withOpacity(.3),
                          blurRadius: 5,
                          offset: const Offset(
                              0, -2), // chaxnges position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kDefaultPadding * 2),
                        topRight: Radius.circular(kDefaultPadding * 2),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(kDefaultPadding * 2)
                              .copyWith(bottom: kDefaultPadding * 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(widget.food.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: kBlack,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900)),
                              const SizedBox(height: kDefaultPadding),
                              Row(
                                children: [1, 2, 3, 4, 5]
                                    .map((rate) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            CupertinoIcons.star_fill,
                                            color: widget.food.rating >= rate
                                                ? kBlack
                                                : kBlack.withOpacity(.4),
                                            size: 15,
                                          ),
                                        ))
                                    .toList(),
                              ),
                              const SizedBox(height: kDefaultPadding * 1.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: kFoodColors[
                                            int.parse(widget.food.id) - 1],
                                        borderRadius: BorderRadius.circular(
                                            kDefaultPadding * 2),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding / 2,
                                          vertical: kDefaultPadding / 2),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              CupertinoIcons.minus_circle_fill,
                                              color: kWhite,
                                              size: 25),
                                          const SizedBox(
                                              width: kDefaultPadding / 2),
                                          Text("1",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: kWhite,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                          const SizedBox(
                                              width: kDefaultPadding / 2),
                                          const Icon(
                                              CupertinoIcons.plus_circle_fill,
                                              color: kWhite,
                                              size: 25),
                                        ],
                                      )),
                                  Text("${widget.food.price}€",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: kBlack,
                                              fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(height: kDefaultPadding * 1.5),
                              Text("About this food",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: kBlack,
                                          fontWeight: FontWeight.bold)),
                              const SizedBox(height: kDefaultPadding),
                              Text(
                                  widget.food.description +
                                      widget.food.description +
                                      widget.food.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: kBlack.withOpacity(.6),
                                          height: 2,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        IgnorePointer(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding * 2)
                                  .copyWith(top: kDefaultPadding * 4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    kWhite.withOpacity(0),
                                    kWhite,
                                  ],
                                  stops: const [0.0, .4],
                                ),
                              ),
                              child: SafeArea(
                                bottom: true,
                                top: false,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 1.5),
                                      decoration: BoxDecoration(
                                        // color: kFoodColors[int.parse(widget.food.id) - 1],
                                        border: Border.all(
                                            color: kFoodColors[
                                                int.parse(widget.food.id) - 1],
                                            width: 2),
                                        borderRadius: BorderRadius.circular(
                                            kDefaultPadding * 2),
                                      ),
                                      child: Icon(CupertinoIcons.heart,
                                          color: kFoodColors[
                                              int.parse(widget.food.id) - 1],
                                          size: 25),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.all(kDefaultPadding),
                                      decoration: BoxDecoration(
                                        color: kFoodColors[
                                            int.parse(widget.food.id) - 1],
                                        borderRadius: BorderRadius.circular(
                                            kDefaultPadding * 2),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              CupertinoIcons.bag_badge_plus,
                                              color: kWhite,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                                width: kDefaultPadding / 2),
                                            Text("Add to cart",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: kWhite,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                            const SizedBox(
                                                width: kDefaultPadding / 2),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
