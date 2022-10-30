import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              backgroundColor: kBackgroundColor,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text("Electronic Store"),
                background: Opacity(
                  opacity: 0.8,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/ele3.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ما هو المتجر الالكتروني؟",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "المتجر الإلكتروني هو متجر بيع بالتجزئة متخصص في بيع أنواع مختلفة من الإلكترونيات. مع تقدم التكنولوجيا ، ظهرت المزيد والمزيد من المتاجر بأحدث الأدوات لتقدم لعملائها. يعد sonos arc مثالًا جيدًا لنوع الإلكترونيات التي تُباع في المتاجر الإلكترونية.",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ماذا تقدم المتاجر الإلكترونية؟",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "1. الإلكترونيات الجديدة والمستعملة:",
                    style: TextStyle(fontSize: 15.0, color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "تحمل بعض المتاجر الإلكترونية منتجات جديدة يمكنك شراؤها. ومع ذلك ، هناك أوقات يكون فيها المتجر به قسم للعناصر المملوكة مسبقًا أيضًا. يعد هذا أمرًا رائعًا إذا كنت تبحث عن توفير بعض المال عند الشراء ولكنك لا تزال تريد أشياء عالية الجودة.",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "2. تسوق عبر الإنترنت:",
                    style: TextStyle(fontSize: 15.0, color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ستبيع العديد من المتاجر الإلكترونية أيضًا عناصرها من خلال موقعها على الويب حتى تتمكن من التسوق لشراء أداتك الجديدة من جهاز الكمبيوتر الخاص بك. تتوفر بعض مواقع الويب على مدار 24 ساعة في اليوم ، بينما يتوفر البعض الآخر بشكل محدود حسب المناطق الزمنية. بغض النظر ، من المريح أن تكون قادرًا على الحصول على ما تحتاجه دون الحاجة إلى مغادرة المنزل.",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "3. تمديد الضمان",
                    style: TextStyle(fontSize: 15.0, color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "إذا كنت قلقًا بشأن تعطل جهازك ، فقد يكون الضمان الممتد هو الخيار المناسب لك. يمكنك العثور على هذا الخيار مع العديد من المتاجر الإلكترونية ، وسيغطي أي أعطال أو أضرار تحدث بعد الشراء. إنه لأمر رائع أن يحدث شيء غير متوقع.",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "4. الملحقات",
                    style: TextStyle(fontSize: 15.0, color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ستوفر متاجر الإلكترونيات أيضًا ملحقات لأجهزتك. يمكنك العثور على أي شيء تحتاجه يتوافق مع ما اشتريته للتو! من أجهزة الشحن إلى الحافظات ، من المؤكد أن المتجر لديه ما تبحث عنه بالضبط.",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "5. عودة السياسة",
                    style: TextStyle(fontSize: 15.0, color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "أخيرًا ، سيكون لمعظم المتاجر الإلكترونية سياسة إرجاع إذا لم تكن راضيًا عن مشترياتك. إنه رائع بشكل خاص إذا كان ذلك بسبب التلف أو الصناعة الخاطئة. يجب أن يعرض المتجر دائمًا بعض الأموال المستردة لهذه العناصر ، لذلك لا تقلق.",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "استنتاج",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "يعد المتجر الإلكتروني مكانًا رائعًا للحصول على الهاتف أو الكمبيوتر المحمول أو التلفزيون التالي. إنهم يقدمون العديد من العناصر المختلفة ، والخبراء متاحون دائمًا إذا كنت بحاجة إلى مساعدة في اختيار أي شيء. يمكن أن تكون سياسة الإرجاع مفيدة أيضًا في حالة ما إذا كان هناك شيء غير مناسب معها أيضًا.",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
