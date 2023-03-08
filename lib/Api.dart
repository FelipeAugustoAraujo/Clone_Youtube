import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'model/Video.dart';
import 'package:youtube/Constantes.dart';





class Api{

  

  Future<List<Video>> pesquisar(String pesquisa) async {

    List<Video> videos = [];
    

    Uri uri = Uri.parse(
      URL_BASE + "/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&channelId=$CHANNEL_ID"
        "&key=$API_KEY"
        "&q=${pesquisa}"
    );
    
    http.Response response = await http.get(uri);
    
    if(response.statusCode == 200){

      
      Map<String, dynamic> dadosJson = json.decode( response.body );
     

       videos = dadosJson["items"].map<Video>(
        (map){

          return Video.fromJson(map);

        }
      ).toList();

      return videos;

      /*
      for(var video in videos){
        //print("resultado" + video.titulo.toString());
        print(video.titulo);
        print("resultado ${video.titulo}");
        //quando usado o cifrão ele só pega a primeira variavel que está acessando,
        //para pegar a variavel dentro do objeto é necessário usar chaves
      }
      */

      /*
      for(var video in dadosJson["items"]){

      }
      */
      //print(dadosJson["items"]);

    }else{

      return videos;
    }

      
  }

}