import 'package:coffee_aplication/models/coffee_concepr_list.dart';
import 'package:coffee_aplication/models/main_coffee_concept_app.dart';
import 'package:flutter/material.dart';

class CoffeeConceptHome extends StatelessWidget {
  const CoffeeConceptHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < -20) {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: const CoffeConceptList(),
                );
              },
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFA89276), Colors.white],
                  ),
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.4,
              left: 0,
              right: 0,
              top: size.height * 0.15,
              child: Hero(
                tag: coffees[6].name,
                child: Image.asset(coffees[6].image),
              ),
            ),
            Positioned(
              height: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: coffees[7].name,
                child: Image.asset(
                  coffees[7].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height, // Solo 'height' o 'bottom', pero no ambos
              left: 0,
              right: 0,
              top: 0,
              child: Hero(
                tag: coffees[8].name,
                child: Image.asset(
                  coffees[8].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: 140,
              left: 0,
              right: 0,
              top: size.height * 0.25, // Ajusta la posición
              child: Image.asset(
                'assets/coffee_concept/logo.png',
                fit: BoxFit.contain, // Usa 'BoxFit' según lo que necesitas
              ),
            ),
          ],
        ),
      ),
    );
  }
}
