import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:icircles/screens/update_webcard/add_webcards.dart';

import 'package:simple_html_css/simple_html_css.dart';

import '../../app_config.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class MyWebards extends StatelessWidget  {
  //get HTML => null;

  //const MyWebards({Key? key}) : super(key: key);

  /*final _htmlContent = """
  <div>
    <h1>This is a title</h1>
    <p>This is a <strong>paragraph</strong>.</p>
    <p>I like <i>dogs</i></p>
    <p>Red text</p>
    <ul>
        <li>List item 1</li>
        <li>List item 2</li>
        <li>List item 3</li>
    </ul>
    <img src='https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg' />
  </div>
  """;*/



  @override
  Widget build(BuildContext context) {

    const String htmlContent = """
<body>

<h1 style='color: white; font-size:50px; font-style:italic; background-color: rgb(0,122,255); font-weight:100;)'> Hello word! </h1>
<h1 style=''>Convert your <span style='color:lightseagreen;'>HTML</span> and <span style='color:dodgerblue'>CSS</span> easily into RichText</h1>
<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Pellentesque in leo id dui bibendum fringilla in et arcu. In vehicula vel est sed mattis.</p>
<p><a href="https://google.com">Need more? click this link</a></p>
<p>We all spell <span style='color:crimson; text-decoration: underline wavy;'>recieve</span> wrong.<br />Some times we delete <del>stuff</del></p>
<div style='font-size:17px'>We write things that are <span style='font-size:1.5em;'>Big,</span> <b>bold</b>&nbsp; or <span style='color:brown'>colorful</span></div>
<p style='font-family:times;'>Some different FONT with <span style='background-color:lightcyan;'>this part highlighted</span></p>
<div style='line-height:2; font-size:17px'><b style='color: rgb(0,122,255); font-weight:500;'>Finally some line heights.</b> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in leo id dui bibendum fringilla in et arcu. In vehicula vel est sed mattis. Duis varius, sem non mattis.</div>

</body>
""";

    // or use HTML.toRichText()
    final TextSpan textSpan = HTML.toTextSpan(
      context,
      htmlContent,
      linksCallback: (dynamic link) {
        debugPrint('You clicked on ${link.toString()}');
      },
      // as name suggests, optionally set the default text style
      defaultTextStyle: TextStyle(color: Colors.grey[700]),
      overrideStyle: <String, TextStyle>{
        'p': const TextStyle(fontSize: 17.3),
        'a': const TextStyle(wordSpacing: 2),
        // specify any tag not just the supported ones,
        // and apply TextStyles to them and/override them
      },
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppCon.color.textColor1)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(AddWebcard());
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_box,
                            color: AppCon.color.textColor1,
                          ),
                          Text(
                            'Add Webcard',
                            style: TextStyle(color: AppCon.color.textColor1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    /*child: Html(
                      data: _htmlContent,
                      // Styling with CSS (not real CSS)
                      style: {
                        'h1': Style(color: Colors.red),
                        'p': Style(
                            color: Colors.black87, fontSize: FontSize.medium),
                        'ul': Style(
                            margin: const EdgeInsets.symmetric(vertical: 20))
                      },
                    ),
                    height: 230,
                    width: 150,
                    decoration: BoxDecoration(
                      //color: AppCon.color.textColor1,
                      borderRadius: BorderRadius.circular(10),
                    ),*/


                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(text: textSpan),

                  ),
                  Container(
                    /*  width: MediaQuery.of(context).size.width* 0.1,
                      height: MediaQuery.of(context).size.height* 1, */
                     height: 30,
                    width: 130,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppCon.color.textColor3)),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: AppCon.color.textColor3,
                          ),
                          Text(
                            '  See Preview',
                            style: TextStyle(color: AppCon.color.textColor3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 215,
                    decoration: BoxDecoration(
                      color: AppCon.color.textColor1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 130,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppCon.color.textColor3)),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: AppCon.color.textColor3,
                          ),
                          Text(
                            '  See Preview',
                            style: TextStyle(color: AppCon.color.textColor3),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
