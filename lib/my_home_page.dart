import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:local_json_project4/api/question_api.dart';
import 'package:local_json_project4/models/question.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyQuestion? question;
  List<MyQuestion?> questions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KPSS - Ezber Sorular",
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: QuestionApi.getUsersLocally(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text("Some error had"));
              } else {
                if (snapshot.data == null) return Container();
                questions = snapshot.data!;
                var random = Random();
                var index = random.nextInt(questions!.length);

                question ??= questions![index];

                return buildQuestion(questions!);
              }
          }
        },
      ),
    );
  }

  Widget buildQuestion(List<MyQuestion?> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 40,
            child: Container(
              child: Center(
                  child: Text(
                question?.question! ?? ",",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )),
            )),
        Expanded(
            flex: 19,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: myCard(question!, 0),
            )),
        Expanded(
            flex: 19,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: myCard(question!, 1),
            )),
        Expanded(
            flex: 19,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: myCard(question!, 2),
            )),
        const SizedBox(
          height: 50.0,
        ),
        Expanded(
          flex: 10,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                var random = Random();
                var index = random.nextInt(questions!.length);
                question = questions![index];
                index++;
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("Değiştir"),
            ),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }

  InkWell myCard(MyQuestion question, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (question.options[index].option == question.answer) {
            question.options[index].isCorrect = true;
          } else {
            question.options[index].isCorrect = false;
          }
        });
      },
      child: Card(
          color: question.options[index].isCorrect == null
              ? Colors.white
              : question.options[index].isCorrect!
                  ? Colors.green
                  : Colors.red,
          child: Center(
            child: Text(question.options[index].toString(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: question.options[index].isCorrect == null
                        ? Colors.black
                        : Colors.white)),
          )),
    );
  }
}
