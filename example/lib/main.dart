import 'package:flutter/material.dart';
import 'package:scroll_highlight_text/scroll_highlight_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Highlight Text',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SearchBar(
                    hintText: 'Start search',
                    controller: controller,
                  ),
                ),
                Expanded(
                  child: HighlightedTextScrollable(
                    searchController: controller,
                    // text: englishContent,
                    showMatchNavigation: true,
                    text: arabicContent,
                    textDirection: TextDirection
                        .rtl, // Add this line if the text is Arabic.
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String englishContent =
    """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vulputate auctor augue, vitae accumsan odio cursus a. Integer gravida luctus erat, id congue mi vehicula vel. Morbi at neque felis. In hac habitasse platea dictumst. Cras ultricies eros quis libero fringilla, eget convallis leo placerat. Vestibulum vitae odio sit amet lacus feugiat placerat. Nullam id consequat mauris. Maecenas vestibulum magna in vehicula tempor. Ut id dapibus mi. Donec at nisl risus. Quisque nec tortor sit amet nunc suscipit iaculis. Vivamus bibendum risus non magna gravida rutrum. Nulla facilisi. Sed hendrerit eget enim at eleifend.

Phasellus at purus ac risus lobortis cursus. Vestibulum bibendum auctor massa sit amet blandit. Sed vel tincidunt est. Vivamus tempor diam vel tortor posuere, eget fermentum arcu tempor. Fusce nec eleifend turpis. Nullam auctor convallis fringilla. Sed id erat velit. Integer pretium ex a nisi vehicula, id euismod sem cursus. Mauris congue massa magna, ut rutrum ipsum dictum non. Integer nec libero a velit dapibus aliquam. Proin blandit ultricies nisi, eget auctor urna cursus ac. Vestibulum euismod augue nec ex ultricies, ac vestibulum lacus mattis. Suspendisse commodo metus ut semper laoreet. Duis tincidunt mauris et risus feugiat, non posuere arcu congue. Donec id arcu nec mauris pharetra ultricies nec in justo.

Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas consequat libero id urna elementum, non viverra elit pharetra. Fusce tempor felis nec velit tincidunt, id feugiat libero ullamcorper. Duis placerat justo vitae felis pharetra, ut cursus dui gravida. Proin id ultrices dui. Vivamus nec nunc urna. Donec commodo euismod tellus, eget maximus sem vehicula sit amet. Fusce placerat rutrum nulla. Nam ac libero ac eros tristique condimentum.

Sed gravida ullamcorper quam ut laoreet. Curabitur gravida leo eget nunc suscipit, ac elementum libero pharetra. Fusce a nisi risus. Proin sollicitudin, ligula ac pretium congue, quam nisi convallis tortor, vel varius nisi ex sed enim. Nullam sem nulla, gravida in ipsum at, consequat auctor leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus efficitur elit a libero aliquet, eget bibendum risus rutrum. Nam eleifend dolor nisl, in sollicitudin orci ultricies in. Aenean eget leo nec nisi fermentum varius.

Suspendisse potenti. Mauris ultricies magna id magna rhoncus, a congue elit luctus. Nulla facilisi. Morbi molestie magna in sapien iaculis condimentum. Maecenas at nisi eros. Aliquam erat volutpat. Curabitur laoreet, justo id dignissim sollicitudin, nisi urna luctus leo, at tempor nunc dolor ut justo. Nam eu rhoncus nulla. Duis vel lacus vitae quam finibus auctor eget ut purus. Nullam euismod, nisi nec varius suscipit, orci odio luctus est, id suscipit tortor nunc in elit. Sed ac ipsum nec erat eleifend consectetur. Nam et lacus vitae urna hendrerit faucibus. In hac habitasse platea dictumst. Sed eu ex nec turpis pellentesque dapibus vel sed risus. Vivamus nec dictum lacus. Sed vitae velit a ex tristique pulvinar.

Phasellus lacinia, purus et sollicitudin faucibus, quam quam vehicula elit, ut dignissim lorem magna vitae purus. Integer non tellus ac dui varius tincidunt. Integer id urna magna. Cras bibendum volutpat felis non scelerisque. Nam condimentum justo ac sapien tincidunt interdum. Nulla facilisi. Aenean tincidunt tortor nisi, nec varius mi rutrum nec. Sed ut commodo ligula. Suspendisse potenti. Sed vel ullamcorper purus. Aliquam vitae viverra nulla. Mauris non ligula non turpis facilisis fringilla.

Duis vel faucibus metus, ac congue mi. Duis quis tellus et orci scelerisque bibendum. Integer bibendum, nunc et posuere vehicula, arcu urna accumsan dui, eget placerat erat enim vitae enim. Curabitur sed orci at arcu laoreet fringilla. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce interdum tincidunt diam a feugiat. Nam quis arcu eros. Vivamus vel orci libero. Aliquam et magna in nisi tincidunt interdum. Sed vitae leo id mi convallis commodo ac et odio. Integer eu erat enim. In at ligula ex. Nam pharetra lectus eu feugiat lobortis.

### Additional Section: Technology and Innovation

Curabitur fermentum, sapien sit amet ultrices faucibus, lorem elit maximus est, vitae luctus ipsum erat sed erat. Etiam id nisl ut libero interdum maximus. Integer sed lacus sed augue dignissim viverra. Quisque tincidunt mauris nec orci placerat, quis dignissim libero efficitur. Donec congue tortor in purus porta, vel luctus est facilisis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; In sed lorem quis nisl luctus malesuada. Integer vel purus id libero tempus tincidunt. Morbi feugiat ligula nec arcu facilisis, sed faucibus libero viverra. Etiam sed turpis in quam volutpat tristique. Sed vel lectus sit amet libero ultricies tristique. Fusce nec risus vel lorem fermentum consectetur.

### Future Outlook

Praesent finibus, odio non porta viverra, mauris lorem tincidunt nisl, sit amet efficitur magna orci ut lorem. Nulla facilisi. Integer viverra sapien at ligula consequat, sed cursus lectus ultrices. Morbi posuere feugiat nisl, sit amet placerat elit fermentum nec. Cras porta risus at erat elementum, non posuere erat tempus. Sed ut erat nec nibh gravida tristique. Mauris feugiat, ligula non porta luctus, orci purus posuere ex, id pretium est justo non odio.

Mauris volutpat sem at magna vestibulum, vitae aliquet mauris porttitor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed luctus, lectus sed tincidunt commodo, tortor leo interdum neque, sit amet convallis massa lorem nec lacus. Suspendisse potenti. Donec quis lorem id arcu elementum tincidunt. Integer sed nunc at urna luctus dignissim sed sed leo.

Curabitur dignissim ligula et lacus vulputate, nec cursus lacus elementum. Duis dignissim ex in nisl facilisis, at tincidunt sapien bibendum. Integer at orci id mauris tincidunt posuere. Cras vel justo vitae libero ultricies pretium. Sed viverra volutpat orci, non faucibus arcu varius vel. Sed vitae orci et augue facilisis aliquet sed nec leo.
""";

const String arabicContent = """    
## تأثير التكنولوجيا في الرياضة الحديثة

تعتبر التكنولوجيا من أهم العوامل التي غيرت وجه الرياضة الحديثة بشكل كبير خلال العقود الأخيرة. فقد أصبحت جزءًا لا يتجزأ من جميع عناصر المنظومة الرياضية، بدءًا من تدريب اللاعبين ومرورًا بإدارة المباريات ووصولًا إلى تجربة المشجعين. ومن خلال التطورات التكنولوجية المتسارعة، تم تحسين الأداء الرياضي، وتوفير بيئة تنافسية أكثر عدالة، وزيادة متعة المشاهدة للجماهير حول العالم. في هذا المقال، سنستعرض مجموعة واسعة من التقنيات التي غيرت واقع الرياضة الحديثة وأسهمت في تطويرها بشكل غير مسبوق.

---

### 1. تقنية VAR في كرة القدم

تُعد تقنية حكم الفيديو المساعد "VAR" من أبرز الابتكارات في عالم كرة القدم خلال السنوات الأخيرة. تهدف هذه التقنية إلى تعزيز العدالة والدقة في اتخاذ القرارات التحكيمية، خاصة في الحالات الحاسمة مثل:
- احتساب الأهداف
- ضربات الجزاء
- حالات الطرد المباشر
- التسلل

من خلال استخدام تقنيات الفيديو المتقدمة والتحليل الحاسوبي، يمكن لحكام المباريات إعادة مشاهدة اللقطات من زوايا متعددة وبسرعات مختلفة، مما يقلل من احتمالية وقوع الأخطاء. وقد ساهمت هذه التقنية في زيادة الشفافية داخل الملاعب وتعزيز ثقة الجماهير بقرارات الحكام.

---

### 2. البيانات الحيوية وتحليل الأداء الرياضي

شهد مجال تحليل الأداء الرياضي ثورة حقيقية بفضل تقنيات جمع البيانات الحيوية. حيث يتم استخدام:
- أجهزة تتبع GPS  
- حساسات الحركة  
- أجهزة قياس معدل ضربات القلب  
- تقنيات تتبع النوم والتعافي  

تساعد هذه البيانات المدربين على فهم حالة اللاعبين البدنية بشكل دقيق، مثل:
- مستوى الإرهاق
- سرعة الجري
- المسافات المقطوعة
- معدلات التسارع

وبناءً على هذه المعلومات، يمكن تصميم برامج تدريب مخصصة لكل لاعب، مما يقلل من الإصابات ويحسن الأداء العام للفريق.

---

### 3. الذكاء الاصطناعي في تحليل المباريات

دخل الذكاء الاصطناعي بقوة إلى عالم الرياضة، حيث يتم استخدامه لتحليل آلاف اللقطات في وقت قصير. يساعد ذلك في:
- تحليل خطط المنافسين
- التنبؤ بنتائج المباريات
- اقتراح تكتيكات هجومية ودفاعية

كما يمكن للأنظمة الذكية اكتشاف نقاط القوة والضعف لدى اللاعبين، مما يمنح الفرق ميزة تنافسية كبيرة.

---

### 4. الواقع الافتراضي والواقع المعزز

أصبح الواقع الافتراضي (VR) والواقع المعزز (AR) من أهم الأدوات الحديثة في التدريب الرياضي. حيث يمكن للاعبين:
- محاكاة المباريات في بيئة افتراضية
- التدرب على اتخاذ القرارات السريعة
- تحسين ردود الفعل والتركيز

كما أصبح بإمكان المشجعين تجربة مشاهدة المباريات وكأنهم داخل الملعب، مما يضيف بعدًا جديدًا لتجربة المشاهدة.

---

### 5. تقنيات البث الحي والفيديو عبر الإنترنت

شهدت السنوات الأخيرة ثورة في تقنيات البث المباشر عبر الإنترنت. حيث أصبح بإمكان الجماهير:
- مشاهدة المباريات بجودة 4K و 8K
- اختيار زوايا الكاميرا المفضلة
- متابعة الإحصائيات المباشرة أثناء المباراة

هذا التطور جعل الرياضة أكثر انتشارًا وسهولة في الوصول، وساهم في زيادة شعبية البطولات العالمية.

---

### 6. تقنيات التحكيم الإلكتروني في الألعاب الأخرى

لم تقتصر التكنولوجيا على كرة القدم فقط، بل امتدت إلى العديد من الرياضات مثل:
- التنس (تقنية Hawk-Eye)
- الكرة الطائرة
- الكريكيت
- ألعاب القوى

حيث تساعد هذه التقنيات في تحديد موقع الكرة بدقة عالية، مما يقلل من الأخطاء التحكيمية ويزيد من عدالة المنافسة.

---

### 7. التكنولوجيا وتجربة المشجعين

أصبح المشجع جزءًا من التجربة الرقمية للرياضة من خلال:
- تطبيقات الهواتف الذكية
- التذاكر الإلكترونية
- الشاشات التفاعلية في الملاعب
- الواقع المعزز داخل المدرجات

كما يمكن للمشجعين متابعة الإحصائيات المباشرة والتفاعل مع المباريات عبر وسائل التواصل الاجتماعي، مما يعزز ارتباطهم بالفرق والبطولات.

---

### 8. إدارة الملاعب الذكية

تُدار العديد من الملاعب الحديثة باستخدام أنظمة ذكية تشمل:
- أنظمة الأمن والمراقبة
- التحكم في الإضاءة والطقس الداخلي
- تنظيم حركة الجماهير
- أنظمة الدفع الإلكتروني داخل الملعب

هذه التقنيات تجعل تجربة حضور المباريات أكثر راحة وأمانًا.

---

### الختام

لقد أصبحت التكنولوجيا شريكًا أساسيًا في تطوير الرياضة الحديثة، حيث ساهمت في تحسين الأداء الرياضي، وتقليل الأخطاء التحكيمية، وتعزيز تجربة المشجعين، وزيادة العدالة في المنافسات. ومع استمرار التطور التكنولوجي، من المتوقع أن نشهد المزيد من الابتكارات التي ستغير مستقبل الرياضة بشكل أكبر.

إن الرياضة والتكنولوجيا يسيران جنبًا إلى جنب نحو مستقبل أكثر تطورًا وإثارة، حيث لم تعد التكنولوجيا مجرد أداة مساعدة، بل أصبحت عنصرًا أساسيًا في نجاح وتطور الرياضة العالمية.

هذا المقال يسلط الضوء على تأثير التكنولوجيا في مجال الرياضة، وكيف أن هذه التقنيات قد ساهمت في تغيير وتحسين العديد من جوانبها، ومن المتوقع أن يستمر هذا التأثير في السنوات القادمة.
    """;
