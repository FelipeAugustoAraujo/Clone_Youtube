import 'package:flutter/material.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';
import 'CustomSearchDelegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {

    
    List<Widget> telas =  [
      Inicio(_resultado),
      EmAlta(),
      Inscricao(),
      Biblioteca()
    ];


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
          ),
        actions: [


          IconButton(
              onPressed: () async{

                var res = await showSearch(context: context, delegate: CustomSearchDelegate());
                
                  _resultado = res as String;
                  print(res.toString());

                
                  
                
              },
              icon: Icon(Icons.search)
          ),

          /*
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.videocam)
          ),
          
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.account_circle)
          ),

          */
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
              child: telas[indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceAtual,
        onTap: (indice){
          setState(() {
            indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            label: "Inicio",
            icon: Icon(Icons.home)

          ),
          BottomNavigationBarItem(
            label: "Em alta",
            icon: Icon(Icons.whatshot)

          ),
          BottomNavigationBarItem(
            label: "Inscrições",
            icon: Icon(Icons.subscriptions)

          ),
          BottomNavigationBarItem(
            label: "Biblioteca",
            icon: Icon(Icons.folder)

          ),
        ]
        ),
    );
  }
}
