import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../home_temp.dart';
import '../temputil.dart';
import 'api_key/api_key.dart';

class OpenAI {
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choices>? choices;
  Usage? usage;

  OpenAI(
      {this.id,
      this.object,
      this.created,
      this.model,
      this.choices,
      this.usage});

  OpenAI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? new Usage.fromJson(json['usage']) : null;
  }
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }
}

class Choices {
  String? text;
  int? index;
  Null? logprobs;
  String? finishReason;

  Choices({this.text, this.index, this.logprobs, this.finishReason});

  Choices.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    index = json['index'];
    logprobs = json['logprobs'];
    finishReason = json['finish_reason'];
  }
}

class openaifetch extends StatefulWidget {
  const openaifetch({Key? key}) : super(key: key);

  @override
  State<openaifetch> createState() => _openaifetchState();
}

class _openaifetchState extends State<openaifetch> {
  final TextEditingController _search = TextEditingController();
  String str = "";
  bool isSearching = false;
  bool first = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;

  Future<void> getstatus() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userMap = value.data();
        status = userMap!['status'];
      });
      print("__________________");
      print(userMap!['status']);
      print("__________________");
    });
  }

  void initState() {
    super.initState();
    getstatus();
  }

  Future<String> answer(
    String question,
  ) async {
    Map reqData = {
      "model": "text-davinci-003",
      "prompt": question,
      "temperature": 0.9,
      "max_tokens": 150,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0.6,
      "stop": [" Human:", " AI:"]
    };
    String apiKey = openAIApiKey;

    var response = await http
        .post(
          Uri.parse('https://api.openai.com/v1/completions'),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 120));

    OpenAI data = OpenAI.fromJson(jsonDecode(response.body));
    print(data.choices![0].text);

    return data.choices![0].text!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            getSearchBarUI(),
            first
                ? result()
                : Container(
                    child: Image.asset(
                    "assets/images/loading.gif",
                    // "https://i.pinimg.com/originals/f3/21/97/f32197f072587bc2bb08a879839fabec.gif",
                  )),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text("Powered by OpenAI"),
            )
          ],
        ),
      ),
    );
  }

  Widget result() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF54D3C2),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 16,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$str',
                style: GoogleFonts.openSans(
                    color: white,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 25.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _search,
                    onSubmitted: (value) async {
                      String str1 = await answer(_search.text);
                      setState(() {
                        str = str1;
                        first = true;
                      });
                    },
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                    ),
                    cursorColor: Color(0xFF54D3C2),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Query...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF54D3C2),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () async {
                  String str1 = await answer(_search.text);
                  setState(() {
                    str = str1;
                    first = true;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
