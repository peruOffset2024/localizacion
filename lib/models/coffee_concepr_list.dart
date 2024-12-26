import 'package:coffee_aplication/models/main_coffee_concept_app.dart';
import 'package:coffee_aplication/screens/coffee_concept_details.dart';
import 'package:flutter/material.dart';

class CoffeConceptList extends StatefulWidget {
  const CoffeConceptList({super.key});

  @override
  State<CoffeConceptList> createState() => _CoffeConceptListState();
}

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class _CoffeConceptListState extends State<CoffeConceptList> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );

  final _pageTextController = PageController(initialPage: _initialPage.toInt());

  double _currenPage = 8.0;
  double _textPage = 5.0;

  void _coffeeScrollListener() {
    setState(() {
      _currenPage = _pageCoffeeController.page!;
    });
  }

  void _textScrollListener() {
    _textPage = _currenPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageTextController.removeListener(_textScrollListener);
    _pageCoffeeController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: 20,
                right: 20,
                bottom: -size.height * 0.2,
                height: size.height * 0.3,
                child: const DecoratedBox(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.brown,
                      blurRadius: 90,
                      offset: Offset.zero,
                      spreadRadius: 45)
                ]))),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                  controller: _pageCoffeeController,
                  scrollDirection: Axis.vertical,
                  itemCount:
                      coffees.length + 1, //simulamos que hay un elemento mas
                  onPageChanged: (value) {
                    if (value < coffees.length) {
                      _pageTextController.animateToPage(value,
                          duration: _duration, curve: Curves.easeInOut);
                    }
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    }
                    final coffee = coffees[index - 1];
                    final result = _currenPage - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 650),
                                pageBuilder: (context, animation, _) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: CoffeeConceptDetails(coffe: coffee),
                                  );
                                }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..translate(
                                  0.0, size.height / 2.6 * (1 - value).abs())
                              ..scale(value),
                            child: Opacity(
                                opacity: opacity,
                                child: Hero(
                                  tag: coffee.name,
                                  child: Image.asset(
                                    coffee.image,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ))),
                      ),
                    );
                  }),
            ),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                height: 100,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: 0.0),
                  duration: _duration,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0.0, -100 * value),
                      child: child,
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: PageView.builder(
                              itemCount: coffees.length,
                              controller: _pageTextController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final opacity = (1 - (index - _textPage).abs())
                                    .clamp(0.0, 1.0);
                                return Opacity(
                                    opacity: opacity,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.1,
                                      ),
                                      child: Hero(
                                        tag: 'text_${coffees[index].name}',
                                        child: Material(
                                          color: Colors.white,
                                          child: Text(
                                            coffees[index].name,
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                    ));
                              })),
                      AnimatedSwitcher(
                        duration: _duration,
                        child: Text(
                          '\$${coffees[_currenPage.toInt()].price.toStringAsFixed(2)}',
                          key: Key(coffees[_currenPage.toInt()].name),
                          style: const TextStyle(fontSize: 22),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}


//