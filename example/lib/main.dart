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
                HighlightedTextScrollable(
                  searchController: controller,
                  text: englishContent,
                  // text: arabicContent,
                  // textDirection:
                  //     TextDirection.rtl, // Add this line if the text is Arabic.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
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

Duis vel faucibus metus, ac congue mi. Duis quis tellus et orci scelerisque bibendum. Integer bibendum, nunc et posuere vehicula, arcu urna accumsan dui, eget placerat erat enim vitae enim. Curabitur sed orci at arcu laoreet fringilla. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce interdum tincidunt diam a feugiat. Nam quis arcu eros. Vivamus vel orci libero. Aliquam et magna in nisi tincidunt interdum. Sed vitae leo id mi convallis commodo ac et odio. Integer eu erat enim. In at ligula ex. Nam pharetra lectus eu feugiat lobortis. Aliquam at est in magna mollis scelerisque non eget odio. Vivamus vel nisi ac nisi accumsan commodo. Integer semper ex non felis tincidunt, ut lacinia lacus dictum. Vivamus eu nulla ut lacus dictum condimentum vel at leo.

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Ut scelerisque neque eu lorem hendrerit suscipit. Fusce a vestibulum ligula. Suspendisse sit amet diam sagittis, dapibus purus vel, viverra ligula. Nam vitae quam a nibh tempus vestibulum. Curabitur id nisl nec ipsum facilisis posuere. Aliquam eu consequat magna. Sed dignissim quam ac urna commodo, eget posuere quam commodo. Vivamus vulputate tellus sit amet massa fringilla, sed fermentum ex feugiat. Ut vel sodales dolor. Fusce interdum, justo ac rutrum condimentum, ex urna molestie nulla, eget tempor leo eros ut dolor. Aliquam non lorem vel dui posuere tristique. Ut tincidunt nec ligula nec eleifend. Vivamus efficitur placerat aliquam.

Aenean vel ligula dolor. Mauris""";

const String arabicContent = """    ## تأثير التكنولوجيا في الرياضة الحديثة

تعتبر التكنولوجيا من أهم العوامل التي غيرت وجه الرياضة الحديثة بشكل كبير. فمن خلال التطورات التكنولوجية، تم تحسين الأداء الرياضي، وتوفير بيئة تنافسية أكثر عدالة، وزيادة متعة المشاهدة للجماهير. في هذا المقال، سنستعرض بعضاً من التقنيات التي غيرت واقع الرياضة الحديثة.

### 1. تقنية VAR في كرة القدم

لقد كانت تقنية "VAR" أحدث الابتكارات التكنولوجية في عالم كرة القدم. تهدف هذه التقنية إلى زيادة العدالة والدقة في اتخاذ القرارات التحكيمية. من خلال استخدام تقنيات الفيديو والتحليل الحاسوبي، يمكن لحكام المباريات إعادة مشاهدة اللقطات الحاسمة واتخاذ القرارات الصحيحة بشأنها. وقد أثبتت تقنية VAR نجاحها في تقليل الأخطاء التحكيمية وزيادة الشفافية في اللعبة.

### 2. البيانات الحيوية في رياضة كرة القدم والرياضات الأخرى

من خلال تطور تقنيات جمع البيانات وتحليلها، أصبح من الممكن الحصول على معلومات دقيقة حول أداء اللاعبين في المباريات. يتم استخدام أجهزة قياس البيانات الحيوية مثل أجهزة GPS وأجهزة مراقبة معدل ضربات القلب لتتبع حركة اللاعبين ومستويات طاقتهم وتحليل أدائهم. هذه البيانات تساعد المدربين على اتخاذ قرارات أفضل فيما يتعلق بتكتيكات الفريق وتدريب اللاعبين.

### 3. الواقع الافتراضي والألعاب الرياضية

شهدنا في السنوات الأخيرة انتشارًا متزايدًا لتقنية الواقع الافتراضي في مجال الرياضة. تمكنت هذه التقنية من توفير تجارب تفاعلية وواقعية للمشجعين، سواء كان ذلك من خلال مشاهدة المباريات أو المشاركة في تدريبات اللاعبين. بفضل الواقع الافتراضي، يمكن للمشجعين العيش لحظات استثنائية والتفاعل مع الرياضة بطرق جديدة ومبتكرة.

### 4. تقنيات البث الحي والفيديو عبر الإنترنت

شهدنا في السنوات الأخيرة ثورة في تقنيات البث الحي والفيديو عبر الإنترنت، مما جعل من الممكن متابعة المباريات والأحداث الرياضية عبر الإنترنت بسهولة وراحة. بفضل هذه التقنيات، أصبح بإمكان المشجعين الوصول إلى المحتوى الرياضي في أي وقت ومن أي مكان، مما زاد من شعبية الرياضة وجذب المزيد من الجماهير.

### الختام

باستخدام التكنولوجيا، تم تحسين تجربة الرياضة للجماهير والمشجعين، وتوفير بيئة تنافسية أكثر عدالة للرياضيين، وتطوير الأداء الرياضي بشكل عام. إن التكنولوجيا ليست فقط مجرد أداة، بل هي شريك أساسي في تطوير وتحسين الرياضة الحديثة.

هذا المقال يسلط الضوء على تأثير التكنولوجيا في مجال الرياضة، وكيف أن هذه التقنيات قد ساهمت في تغيير وتحسين عدة جوانب منها.
    """;
