
import 'package:coffee_aplication/models/coffee.dart';

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return  Center(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainCoffeeConceptApp() ));
                    },
                    title: const Text('Challenger Coffee'),
                    subtitle: const Text('entrando en animaciones'),
                    trailing: const Icon(Icons.coffee),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: 3)),
    );
  }
}
