import 'package:flutter/material.dart';

class ObservacaoView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Observação"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text("Aluno",style: TextStyle(fontSize: 16),),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  minLines: 10,
                  maxLines: 15,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Escreve uma observação aqui',
                    filled: true,
                    //fillColor: Colors.blue.shade10,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: Text("Cancelar", style: TextStyle(color: Colors.white)),
                    color: Colors.red.shade700,
                    onPressed: (){},
                  ),
                  FlatButton(
                    padding: EdgeInsets.only(left: 70,right: 70),
                    color: Colors.green,
                    onPressed: (){},
                    child: Container(
                        child: Text("Salvar", style: TextStyle(color: Colors.white))
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
