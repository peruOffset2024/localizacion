import 'package:coffee_aplication/models/main_coffee_concept_app.dart';
import 'package:flutter/material.dart';

class CoffeeConceptDetails extends StatelessWidget {
  const CoffeeConceptDetails({super.key, required this.coffe});
  final Coffe coffe;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: Hero(
              tag: coffe.name,
              child: Material(
                color: Colors.white,
                child: Text(
                  coffe.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * 0.4,
            width: size.width * 0.99,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                      tag: 'text_${coffe.name}',
                      child: Image.asset(
                        coffe.image,
                        fit: BoxFit.contain,
                      )),
                ),
                Positioned(
                  right: 0,
                  left: 128,
                  bottom: 50,

                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(-100 * value, 240 * value),
                        child: child,
                      );
                    },
                    child: Text(
                      '\$${coffe.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10
                            )
                          ]
                          ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
