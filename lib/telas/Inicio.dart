import 'package:flutter/material.dart';

import '../Api.dart';
import '../model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube/Constantes.dart';

class Inicio extends StatefulWidget {

  String pesquisa;

  Inicio(this.pesquisa, {super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {


  listarVideos(String pesquisa){

    
    Api x = Api();
    

    return x.pesquisar(pesquisa);

  }


  @override
  void initState() {
    super.initState();
    print("chamado 1 - initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 - didChangeDependencies");
  }

  @override
  void didUpdateWidget(Inicio oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("chamado 2 - didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("chamado 4 - dispose");
  }



  @override
  Widget build(BuildContext context) {

    print("chamado 3 - build");


    return FutureBuilder< List<Video> >(
      future: listarVideos(widget.pesquisa),//metodo que vai trazer os videos
      builder: (context, snapshot){

        switch(snapshot.connectionState){

          case ConnectionState.none:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator()
              );
            break;
          case ConnectionState.waiting:
          case ConnectionState.done:
            if(snapshot.hasData){

              return ListView.separated(
                itemBuilder: (context, index){


                  List<Video>? videos = snapshot.data;
                  Video video = videos![index];

                  return GestureDetector(
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY, 
                        videoId: video.id,
                        autoPlay: true,
                        fullScreen: true
                        );
                    },
                    child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(video.imagem.toString())
                          
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(video.titulo.toString()),
                        subtitle: Text(video.canal.toString()),
                      )
                    ]

                  )
                  );
                }, 
                separatorBuilder: (context, index) => Divider(
                  height: 3,
                  color: Colors.red,
                ), 
                itemCount: snapshot.data!.length
                );
              
            }else{
              return Center(child: Text("Nenhum dados"));
            }
            break;

        }


      }
      );
  }
}