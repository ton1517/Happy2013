package {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    
    import a24.tween.Ease24;
    import a24.tween.Tween24;
    import a24.tween.plugins.TextPlugin;
    import a24.util.Align24;
    
    [SWF(frameRate = 30, width = 465, height = 465)]
    public class Happy2013 extends Sprite {
        private static const BTN_SPACE:int = 20;
        private static const OPT_D:int = 5;
        
        private var _lines:Vector.<Vector.<Point>>;
        
        private var _bg:Shape;
        
        private var _txtHappyNewYear:String;
        private var _txtPleaseWrite:String;
        private var _txtRewrite:String;
        private var _txtNext:String;
        
        private var _message:TextField;
        private var _messageFontSize:int;
        
        private var _nextButton:NavigationButton;
        private var _retrybutton:NavigationButton;
        private var _btns:Array;
        private var _panel:DrawingPanel;
        
        private var _colors:Array = [0xe60033, 0xf8b500, 0x4d5aaf, 0x69821b];
        private var _dotLayers:Array = [];
        private var _snakeMaskLayers:Array = [];
        private var _snakes:Array = [];
        
        private var _stageRect:Rectangle;
        
        private var _fontLines:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
        
        public function Happy2013() {
            init();
            startAnimation();
        }
        
        private function init():void {
            stage.align = StageAlign.TOP;
            stage.scaleMode = StageScaleMode.SHOW_ALL;
            
            if(Capabilities.language == "ja") {
                _messageFontSize = 28;
                _txtHappyNewYear = "あけましておめでとうございます";
                _txtPleaseWrite = "「2013」と書いてください";
                _txtRewrite = "書き直す";
                _txtNext = "次へ";
            } else {
                _messageFontSize = 36;
                _txtHappyNewYear = "Happy New Year !";
                _txtPleaseWrite = "Please write '2013'";
                _txtRewrite = "Rewrite";
                _txtNext = "Next";
            }
            
            _fontLines.push(new <Point>[new Point(62.5, 10.5),new Point(62.5, 15.5),new Point(62.5, 20.5),new Point(63.480580675690916, 25.4029033784546),new Point(64.06707746895506, 30.3683863873361),new Point(64.65357426221921, 35.333869396217594),new Point(65.24007105548337, 40.29935240509909),new Point(65.44948536275194, 45.29496504499735),new Point(65.49800785968274, 50.29472959618289),new Point(65.49939027847445, 55.29472940507471),new Point(65.49988157173337, 60.2947293809378),new Point(65.4999953297637, 65.29472937964371),new Point(65.49999857061096, 70.29472937964266),new Point(65.49999994363183, 75.29472937964248),new Point(65.49999998905142, 80.29472937964248),new Point(65.49999999787342, 85.29472937964248),new Point(65.49999999958695, 90.29472937964248),new Point(65.49999999998371, 95.29472937964248),new Point(65.49999999999936, 100.29472937964248),new Point(65.49999999999991, 95.29472937964248),new Point(66.22802228658834, 90.34801495992603),new Point(66.46030969719314, 85.35341361859012),new Point(67.33472911301796, 80.43046829234197),new Point(67.47401553943983, 75.43240873973411),new Point(67.49591575943967, 70.43245670192775),new Point(67.4993580429637, 65.43245788685948),new Point(65.62106410242366, 60.798667659310276),new Point(70.45282557217014, 59.5125568167025),new Point(75.35979754217338, 60.47257040285767),new Point(80.26281294738295, 61.45259077829772),new Point(85.26266851342768, 61.490594971375515),new Point(90.26266429157795, 61.4970925462763),new Point(95.26266352112751, 61.49986824506434),new Point(100.26266351954534, 61.49999402935961),new Point(105.26266351954209, 61.49999972943293),new Point(110.17394015395077, 60.56225679007732),new Point(110.4045412876991, 55.56757730915825),new Point(110.48319450950932, 50.56819598036377),new Point(110.49977377969569, 45.568223467659315),new Point(111.46786344085014, 40.66283842589492),new Point(111.49393594187424, 35.66290640388799),new Point(112.45026770437666, 30.755215545650376),new Point(112.47340998477051, 35.75516198884936),new Point(112.49655226516435, 40.755108432048345),new Point(113.23231212676579, 45.700677906442195),new Point(114.14873660227067, 50.61597710188245),new Point(115.11180748908195, 55.522349944112904),new Point(115.87586526665913, 60.46362667310955),new Point(116.39010205020779, 65.43711242562212),new Point(117.1663018783931, 70.37649637776889),new Point(117.49126757747102, 75.3659249316639),new Point(117.49663537738891, 80.36592205033547),new Point(117.4999121311912, 85.36592097662381),new Point(117.4999837546643, 90.36592097611081),new Point(117.499999575745, 95.36592097608579),new Point(117.49999998892037, 100.36592097608577)]);
            _fontLines.push(new <Point>[new Point(161.48058067569093, 82.5970966215454),new Point(164.4468980504761, 78.5720548538059),new Point(164.49924275200442, 73.57232885809154),new Point(165.4670725380385, 68.66689253649228),new Point(165.49376912178005, 63.66696380775859),new Point(165.4997986527786, 58.66696744328432),new Point(163.6950775487641, 54.00403041425158),new Point(159.3430052976226, 51.5424319252928),new Point(154.42072725647606, 50.664264011026724),new Point(149.4567897995806, 51.263701183739755),new Point(146.59507955103646, 55.36377611639372),new Point(144.7066286987533, 59.993436295986925),new Point(143.10077050902936, 64.72854130796887),new Point(142.20310836734998, 69.64730158667687),new Point(141.60672624803215, 74.61160701319507),new Point(139.62784859974033, 79.20334342256038),new Point(138.2280564918758, 84.00340405288165),new Point(137.23154657158028, 88.90309465319027),new Point(136.80760780030505, 93.8850898276369),new Point(136.60579509081242, 98.88101533051295),new Point(141.0142858624444, 101.24008487515036),new Point(146.00868304710093, 101.47672122462976),new Point(151.00863812072453, 101.49791702010442),new Point(155.54792835804713, 99.4015286635856),new Point(160.04234198513257, 97.21058225879409),new Point(163.47903363179736, 93.57889525056439),new Point(165.32763197025474, 88.93317849391073),new Point(166.0161036743506, 83.98080464769724),new Point(166.24670686598327, 78.9861252617898),new Point(166.4773100576159, 73.99144587588235),new Point(166.497969233008, 68.99148855621729),new Point(166.49981824610558, 63.99148889810225),new Point(167.3930647396334, 68.91105297450173),new Point(167.44882091972923, 73.9107420896749),new Point(167.4876549867032, 78.91059127892474),new Point(167.49869817910763, 83.91057908370001),new Point(168.633288941555, 88.78014824346857),new Point(169.97156521284435, 93.59772197115598),new Point(171.69139907740785, 98.29263107339646),new Point(173.331851480544, 103.01586258508894)]);
            _fontLines.push(new <Point>[new Point(194.5, 74.5),new Point(195.48058067569093, 69.5970966215454),new Point(197.32225669408135, 64.948631343275),new Point(200.74507947528616, 61.303870142803106),new Point(205.4199759458283, 59.53035865715865),new Point(210.34968929079258, 58.69493880075046),new Point(214.78672459241503, 56.390005454174876),new Point(219.72713953575249, 55.62039504127234),new Point(224.72605252598808, 55.51614094756895),new Point(229.65500868528062, 56.356016640616474),new Point(231.34306249508307, 61.06244568344835),new Point(231.46491846969744, 66.06096057503873),new Point(230.59152587592084, 70.98408817618174),new Point(227.76705379780088, 75.1099041536486),new Point(225.82855584136047, 79.71883306098448),new Point(223.33373070139749, 84.05194366665896),new Point(220.06942368169746, 87.83933058657315),new Point(216.1672177815292, 90.96547663445577),new Point(211.34101112637748, 92.27227781358339),new Point(207.39703390920812, 89.1989988300791),new Point(205.52526049756804, 84.56257086283134),new Point(203.66812359941147, 79.92026081916715),new Point(202.61475479543552, 75.03247868789225),new Point(200.82951284232075, 70.36204924630565),new Point(200.5095046438429, 75.35179821322842),new Point(200.50027362684082, 80.35178969205367),new Point(200.50000787736278, 85.35178968499139),new Point(200.5000030435634, 90.35178968498906),new Point(200.50000008762026, 95.35178968498818),new Point(200.50000000252248, 100.35178968498818),new Point(199.69730344607544, 105.28693692071155),new Point(198.75117393972056, 110.19660482772977),new Point(196.79750634881938, 114.79912402315551),new Point(194.60199534621046, 119.29130962010308)]);
            _fontLines.push(new <Point>[new Point(255.5, 78.5),new Point(255.5, 73.5),new Point(256.48058067569093, 68.5970966215454),new Point(259.44689805047614, 64.5720548538059),new Point(262.9741753027152, 61.02828353135336),new Point(267.3392433362745, 58.58980427936069),new Point(271.97368796125596, 56.71312555939276),new Point(276.46550720964916, 54.516865137729525),new Point(281.46547915500975, 54.50011564199802),new Point(286.4654791536907, 54.50000079293736),new Point(289.05962463205793, 58.774390718653876),new Point(291.6348602313078, 63.060200048098665),new Point(292.42018496749154, 67.99814142672376),new Point(294.8624618045032, 72.3610858283173),new Point(296.3805248378223, 77.12506364384814),new Point(296.49163839273916, 82.12382886917266),new Point(296.4981953058924, 87.12382456985979),new Point(296.49987372396987, 92.12382428815106),new Point(294.063527492542, 96.49008321778489),new Point(291.51340588000454, 100.79088311562592),new Point(288.8184095401589, 105.00241427759285),new Point(284.6408308322616, 107.74974682741698),new Point(279.83232889648104, 109.12026101325915),new Point(274.84129521217227, 109.41956480891672),new Point(269.9137865377495, 108.57123806556335),new Point(266.2385135675919, 105.18119845003835),new Point(262.2900118041433, 102.11373470550224),new Point(259.1162355368707, 98.25016845069347),new Point(258.6616664659393, 93.27087462930146),new Point(258.5216503712727, 88.27283546446549),new Point(258.50289856451593, 83.2728706276148),new Point(258.50038805948515, 78.27287125787838),new Point(259.3534773305785, 73.34618487699869),new Point(260.43923997171987, 78.22687330047972),new Point(260.49684905129766, 83.22654140885953),new Point(260.4990151105164, 88.22654093967826),new Point(260.49994892782223, 93.22654085247679),new Point(260.4999896327799, 98.2265408523111),new Point(259.7129257239541, 103.16420532080467),new Point(259.5449865816786, 108.1613841693643),new Point(258.5845082499099, 113.06826519239745),new Point(257.8625086155905, 118.01586223824128),new Point(256.6569318667252, 122.86834456202108),new Point(254.54612734242627, 127.40094913998718)]);
            _fontLines.push(new <Point>[new Point(308.53069233026724, 41.06905774310128),new Point(310.38599237361416, 45.71210219143008),new Point(313.06478763865636, 49.93395675168999),new Point(315.74358290369855, 54.155811311949904),new Point(318.4223781687408, 58.3776658722098),new Point(321.19463662577476, 62.538745425331044),new Point(323.9668950828087, 66.69982497845228),new Point(326.30045704140093, 71.12187072509616),new Point(328.8568588995827, 75.41894060345336),new Point(330.8499835085582, 80.00451082896471),new Point(333.02174916523853, 84.5082241782426),new Point(335.8802336420487, 88.61054870170916),new Point(339.2865968384109, 92.27069757497502),new Point(342.07988840325686, 88.12370803631443),new Point(344.67795177365014, 83.85169835427709),new Point(346.9843188633182, 79.41540814198305),new Point(349.2622871704226, 74.96446887124166),new Point(351.81101308746616, 70.66284171401495),new Point(354.7178524899041, 66.59463760305465),new Point(358.1104549313521, 62.92173021594546),new Point(360.4875940519956, 58.52295656854029),new Point(362.34711477088246, 53.881600872622286),new Point(361.2992985050292, 58.7705763351311),new Point(359.8012093596744, 63.540872857630525),new Point(357.17245108687894, 67.79406341804628),new Point(355.0036660196417, 72.29921284199756),new Point(352.8348809524044, 76.80436226594884),new Point(350.9383443820239, 81.43071601779374),new Point(348.75141014767854, 85.92708329089858),new Point(346.53448031653267, 90.40873724047741),new Point(344.67911887305945, 95.05175715364524),new Point(341.77183648539364, 99.11964470351286),new Point(339.49033086986, 103.5687718231048),new Point(336.89773952371473, 107.84410457177978),new Point(334.3229195906953, 112.13016363722973),new Point(332.72499202051506, 116.86795082962851),new Point(330.77881501047256, 121.47364242216726),new Point(328.6644680982757, 126.00459564802202),new Point(326.4745984223078, 130.49953400157887),new Point(324.63817815940024, 135.15007812221492),new Point(321.71282838284986, 139.20499226246952)]);
            _fontLines.push(new <Point>[new Point(24.5, 222.5),new Point(23.51941932430908, 217.5970966215454),new Point(23.500370064686443, 212.5971329091063),new Point(22.690832904354444, 207.6631031578744),new Point(21.56711991554471, 202.79101232140795),new Point(21.503696782633956, 197.79141458696853),new Point(21.5002035941198, 192.79141580720528),new Point(21.500011212603145, 187.79141581090636),new Point(21.500000617515227, 182.79141581091758),new Point(21.50000003400861, 177.7914158109176),new Point(21.500000001872966, 172.7914158109176),new Point(21.50000000010315, 167.7914158109176),new Point(22.428491398251673, 162.87838174594674),new Point(22.49496332754804, 157.8788236172102),new Point(23.413322682804612, 152.96388556118012),new Point(23.492631090565403, 147.96451458310113),new Point(23.499373594975005, 142.96451912923976),new Point(26.428163305075405, 147.01694936725866),new Point(29.254393645591826, 151.14156111411975),new Point(31.186943112334465, 155.75298741826825),new Point(33.37710376822382, 160.24778399891505),new Point(35.93245473026061, 164.54547889976803),new Point(38.85413481291854, 168.60303795597412),new Point(41.230926517790095, 173.00199933244173),new Point(44.17049113217859, 177.04662043680182),new Point(46.488016875892704, 181.47709156606362),new Point(50.01874013461436, 185.01742958245723),new Point(53.96671937838346, 188.08556580674198),new Point(57.09112909588919, 191.9891620867325),new Point(60.586017654547916, 195.56487935219914),new Point(64.1120172802863, 199.10992189627288),new Point(67.64670712904402, 202.64629965792238),new Point(71.18205410526141, 206.1820204836877),new Point(74.07301958653213, 202.10252068762185),new Point(74.45297871386893, 197.11697848425484),new Point(74.48850860040255, 192.11710472313217),new Point(74.49873751379903, 187.11711518621004),new Point(74.499861298987, 182.11711531249935),new Point(74.49996610372926, 177.11711531359776),new Point(74.49999171630297, 172.11711531366336),new Point(74.49999797559923, 167.11711531366728),new Point(74.49999977759248, 162.1171153136676),new Point(74.49999997556556, 157.1171153136676),new Point(74.49999999731556, 152.1171153136676),new Point(74.49999999970508, 147.1171153136676)]);
            _fontLines.push(new <Point>[new Point(92.5, 194.5),new Point(97.5, 194.5),new Point(102.5, 194.5),new Point(107.5, 194.5),new Point(112.5, 194.5),new Point(117.5, 194.5),new Point(122.5, 194.5),new Point(127.5, 194.5),new Point(128.48058067569093, 189.5970966215454),new Point(128.49019694912167, 184.59710586882542),new Point(128.4998132225524, 179.59711511610544),new Point(128.49999644133717, 174.59711511946236),new Point(124.54654233542875, 171.53603677474854),new Point(119.61836140123101, 170.6916241506068),new Point(114.62186183888164, 170.5045623334377),new Point(109.6218638224998, 170.50010855103275),new Point(107.66857025388089, 175.10278649270887),new Point(106.6105178815981, 179.9895569167729),new Point(105.25785568721511, 184.8031112156135),new Point(104.59851549802886, 189.75944761611376),new Point(103.65876416147987, 194.6703403481386),new Point(103.52264530779195, 199.66848717047893),new Point(103.50322913079538, 204.66844947154388),new Point(105.41295345034025, 209.28937503070827),new Point(109.34483764402493, 212.37811048190065),new Point(114.2304828649639, 213.44134647410382),new Point(119.23017316135713, 213.49699663269664),new Point(124.14302398697474, 212.56753616273116)]);
            _fontLines.push(new <Point>[new Point(136.27350098112615, 160.6602514716892),new Point(139.0470019622523, 164.82050294337841),new Point(141.02951441792172, 169.41067117157175),new Point(142.4174174256628, 174.21418293288798),new Point(144.6189518724948, 178.703419625179),new Point(146.5703523212136, 183.30690051345692),new Point(148.31190528704178, 187.9937964230345),new Point(150.49591408429032, 192.4915853880195),new Point(152.07796303006785, 197.2346984093552),new Point(154.16748981677156, 201.77715124979807),new Point(156.3815739139044, 206.26021176810735),new Point(157.98897766181287, 210.99479233994364),new Point(159.12197586381166, 206.12485239429057),new Point(159.91083866407809, 201.18747500519464),new Point(161.5067647624061, 196.44901324121727),new Point(162.3301575203981, 191.5172767958984),new Point(163.46551822594932, 186.64788709406818),new Point(166.41771489401646, 182.61247697450744),new Point(169.41642422528628, 178.6115092982377),new Point(172.08398188319075, 182.8404732543096),new Point(172.45053082017301, 187.82701934121152),new Point(174.45876947760348, 192.40599056789574),new Point(175.46008056426638, 197.30470224625833),new Point(177.28749619017992, 201.9587920745886),new Point(180.68787343484553, 205.62450272792177),new Point(183.76767086785108, 209.56339188244903),new Point(186.38867295791394, 205.30541724139184),new Point(188.39992634252664, 200.7277693931095),new Point(188.4802606754205, 195.72841479526804),new Point(188.4991375096769, 190.72845042888216),new Point(188.49996231458144, 185.72845049691247),new Point(190.98837641693842, 181.3916549915663),new Point(193.27217867907095, 176.94370633769466),new Point(196.21067572988764, 172.8983095608208),new Point(199.20519149908358, 168.89420225606023)]);
            _fontLines.push(new <Point>[new Point(211.27350098112615, 139.6602514716892),new Point(214.6079928791447, 143.38599485818924),new Point(218.06423524861603, 146.99908061464052),new Point(221.57389938140847, 150.5602963726353),new Point(225.10331370799858, 154.10193928394926),new Point(228.63829504516886, 157.63802567229695),new Point(232.17370564283178, 161.17368288219907),new Point(236.13753464889558, 164.22131468586028),new Point(239.2270066459304, 168.1526201661731),new Point(242.23432782935197, 172.1471187955062),new Point(247.0770472150832, 173.39133298569328),new Point(249.9438078933072, 169.294787707805),new Point(253.36278617077227, 165.64641991683024),new Point(257.3426064169691, 162.61970043726797),new Point(261.34184199275757, 159.61868147542384),new Point(265.9668930936741, 157.7189703621462),new Point(270.0436108361627, 154.82408306760797),new Point(273.165501161277, 150.91847161766088),new Point(276.17742248162176, 146.92744042759827),new Point(271.58001589757754, 144.96177191511026),new Point(267.10725327705717, 147.19658612225942),new Point(264.9013247705361, 151.68366528627223),new Point(260.81778056497376, 154.5689151404821),new Point(258.6908465784962, 159.09397335194927),new Point(256.812899577143, 163.72790419520845),new Point(254.63217625282277, 168.22728701763708),new Point(252.07857661311888, 172.5260227480704),new Point(248.7327214749419, 176.24156488809984),new Point(245.7094925457607, 180.22403734145865),new Point(245.51111396850072, 185.22010038550488),new Point(245.50058920033266, 190.2200893084181),new Point(246.43050457663733, 195.1328540486547),new Point(246.49524065701928, 200.13243495508044),new Point(246.49967408360095, 205.13243298955294),new Point(246.499977681486, 210.13243298033578),new Point(246.49999847164466, 215.13243298029255),new Point(245.58423624806468, 220.04785560198684)]);
            _fontLines.push(new <Point>[new Point(280.5, 200.5),new Point(285.5, 200.5),new Point(290.5, 200.5),new Point(295.5, 200.5),new Point(300.5, 200.5),new Point(305.5, 200.5),new Point(310.5, 200.5),new Point(315.5, 200.5),new Point(318.07247877713763, 196.21253537143727),new Point(318.39028473792695, 191.2226456560942),new Point(316.5322921584327, 186.58067801569163),new Point(312.55915332597414, 183.54519324089708),new Point(307.6625579877993, 182.53358358586),new Point(303.01046950674555, 180.70107907987727),new Point(298.01379505406635, 180.51874857243845),new Point(293.8416604640181, 183.27434160525792),new Point(292.59826368688, 188.1172709310485),new Point(292.5212965753416, 193.11667850232547),new Point(290.76373482851403, 197.79759472739173),new Point(289.68191045481655, 202.6791575943918),new Point(289.52572886220275, 207.67671773011088),new Point(290.35079215783304, 212.6081749750035),new Point(293.4959885290832, 216.49504258096525),new Point(297.4950540589936, 219.49628813697734),new Point(302.1368829205645, 221.3546274009136),new Point(307.1350470953719, 221.49010759013757),new Point(312.13503859552156, 221.4993270494893),new Point(317.0504918962504, 220.58372951325737)]);
            _fontLines.push(new <Point>[new Point(370.5, 204.5),new Point(370.5, 199.5),new Point(368.6430466182295, 194.8576165455737),new Point(365.7181147235011, 190.80240096422656),new Point(363.788530944174, 186.18973292516742),new Point(359.5527179491196, 183.53306428363),new Point(354.5528250009715, 183.50034567946054),new Point(350.9940234754371, 187.0124578220115),new Point(348.5651059604422, 191.3828536513788),new Point(347.5462205267601, 196.27794021578504),new Point(345.7220547853955, 200.9333047931336),new Point(342.83953140056957, 205.01877403618653),new Point(342.53040178114287, 210.0092087746029),new Point(342.50271787012394, 215.0091321341226),new Point(344.211888858027, 219.70793352746864),new Point(348.9473580686935, 221.312717424082),new Point(353.94451645479586, 221.48126434398023),new Point(358.944488021292, 221.49812655707407),new Point(363.3446274379602, 219.12351645984063),new Point(367.43527899254275, 216.2483521412336),new Point(370.68679340197286, 212.44997695633307),new Point(373.7381275600788, 208.4889972977668),new Point(375.8319932512092, 203.94854286373632),new Point(376.4404514292343, 198.98570308739914),new Point(375.0130532524185, 203.77762696459325),new Point(375.43699732457225, 208.75962168796318),new Point(377.43222902041674, 213.34427548949472),new Point(381.38279810953117, 216.40907627782232),new Point(385.38138875529535, 219.4109544978051)]);
            _fontLines.push(new <Point>[new Point(407.5, 146.5),new Point(407.5, 151.5),new Point(408.48058067569093, 156.4029033784546),new Point(408.49650565360866, 161.4028780178981),new Point(409.46233939276783, 166.30870773246238),new Point(409.4986113018742, 171.30857616559237),new Point(410.44561864111427, 176.21807482629342),new Point(410.49709464186185, 181.21780984140642),new Point(410.49940701840103, 186.21780930669786),new Point(410.49996832111583, 191.2178092751918),new Point(411.43005366827606, 196.13054183935583),new Point(411.4951816529036, 201.1301176559245),new Point(411.49966810609567, 206.13011564309787),new Point(411.49997713873177, 211.13011563354775),new Point(411.4999984252872, 216.13011563350244),new Point(411.4999998915318, 221.13011563350221),new Point(411.49999998786035, 216.13011563350221),new Point(411.49999999864133, 211.13011563350221),new Point(411.49999999984794, 206.13011563350221),new Point(411.499999999983, 201.13011563350221),new Point(411.4999999999981, 196.13011563350221),new Point(411.4999999999998, 191.13011563350221),new Point(411.5, 186.13011563350221),new Point(411.5, 181.13011563350221),new Point(411.5, 176.13011563350221),new Point(412.37439580988547, 171.20716611439735),new Point(416.42578726981355, 168.27693963195242),new Point(421.3681873640679, 167.52018253200907),new Point(426.3681486966932, 167.500518548384),new Point(431.36814867116794, 167.50001332292956),new Point(436.3681486711511, 167.50000034230257),new Point(439.4505546902776, 171.4368484639924)]);
            
            _stageRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            
            _bg = new Shape();
            _bg.graphics.beginFill(0x000000);
            _bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            _bg.graphics.endFill();
            stage.addChild(_bg);
            
            _message = new TextField();
            _message.autoSize = TextFieldAutoSize.CENTER;
            _message.selectable = false;
            _message.defaultTextFormat = new TextFormat("_sans", _messageFontSize, 0x00a3af, true);
            _message.text = " ";
            _message.x = stage.stageWidth / 2 - _message.width / 2;
            _message.y = stage.stageHeight / 2 - _message.height;
            stage.addChild(_message);
            
            _nextButton = new NavigationButton(_txtNext, 24, false);
            _nextButton.x = stage.stageWidth - _nextButton.width - BTN_SPACE;
            _nextButton.y = stage.stageHeight - _nextButton.height - BTN_SPACE;
            _nextButton.addEventListener(MouseEvent.CLICK, clickedNextButton);
            
            _retrybutton = new NavigationButton(_txtRewrite, 24, true);
            _retrybutton.x = BTN_SPACE;
            _retrybutton.y = stage.stageHeight - _retrybutton.height - BTN_SPACE;
            _retrybutton.addEventListener(MouseEvent.CLICK, clickedRetryButton);
            
            _btns = [_nextButton, _retrybutton];
            
            _panel = new DrawingPanel(stage, 4, stage.stageWidth - stage.stageWidth / 30, stage.stageHeight / 2);
            _panel.x = stage.stageWidth / 2 - _panel.width / 2;
            _panel.y = stage.stageHeight / 2 - _panel.height / 2;
            _panel.alpha = 0;
            _panel.addEventListener(Event.COMPLETE, completeDrawing);
            
            for (var i:int = 0; i < _colors.length; i++) {
                _dotLayers[i] = new DotLayer(_colors[i], stage.stageWidth, stage.stageHeight);
                stage.addChild(_dotLayers[i]);
                _snakeMaskLayers[i] = new Sprite();
                stage.addChild(_snakeMaskLayers[i]);
                _dotLayers[i].mask = _snakeMaskLayers[i];
            }
        }
        
        private function startAnimation():void {
            Tween24.serial(
                Tween24.wait(1),
                Tween24.tween(_bg, 0.7).color(0xffffff, 1),
                Tween24.wait(0.5),
                TextPlugin.typingTween(_message, _txtHappyNewYear, 0.1),
                Tween24.wait(0.5),
                Tween24.tween(_message, 0.5).alpha(0),
                Tween24.wait(0.3),
                Tween24.prop(_message).alpha(1),
                TextPlugin.typingTween(_message, _txtPleaseWrite, 0.1, true),
                Tween24.wait(1),
                Tween24.addChild(stage, _panel),
                Tween24.parallel(
                    Tween24.tween(_message, 1, Ease24._4_QuartInOut).y(10),
                    Tween24.prop(_panel).scale(0.01).align(Align24.MIDDLE_CENTER),
                    Tween24.tween(_panel, 1, Ease24._4_QuartInOut).scale(1).align(Align24.MIDDLE_CENTER).alpha(1)
                ),
                Tween24.func(_panel.start)
            ).play();
            
        }
        
        private function changeToSnake():void {
            var lineCanvas:Sprite = _panel.canvas;
            lineCanvas.x = _panel.x;
            lineCanvas.y = _panel.y;
            stage.addChild(lineCanvas);
            
            
            for (var i:int = 0; i < _lines.length; i++) {
                _lines[i] = optimize(_lines[i], OPT_D);
                var snake:Snake = new Snake(_lines[i], null, _colors[i%_colors.length], 0);
                _snakes.push(snake);
                _snakeMaskLayers[i%_snakeMaskLayers.length].addChild(snake);
                Tween24.tween(snake, 1, null, {"thickness": 5}).delay(3).play();
            }
            
            var objs:Array = [_message, _panel, _nextButton, _retrybutton];
            Tween24.serial(
                Tween24.addChild(stage, _dotLayers),
                Tween24.tween(objs, 1).fadeOut(),
                Tween24.removeChild(objs),
                Tween24.wait(1.5),
                Tween24.tween(lineCanvas, 1.5).fadeOut(),
                Tween24.removeChild(lineCanvas),
                Tween24.wait(1.5),
                Tween24.func(moveSnake)
            ).play();
        }
        
        private function nextStage():void {
            var offsetY:Number = stage.stageHeight - (_panel.y + _panel.height);
            for (var li:int = 0; li < _lines.length; li++) {
                for (var lj:int = 0; lj < _lines[li].length; lj++) {
                    _lines[li][lj].y += offsetY;
                }
            }
            
            _fontLines = _fontLines.concat(_lines);
            
            _snakes = [];
            for (var i:int = 0; i < _fontLines.length; i++) {
                var dist:Number = distance(_fontLines[i]);
                var n:int = dist/OPT_D;
                var l:Vector.<Point> = new Vector.<Point>();
                for (var j:int = 0; j < n; j++) {
                    l.push(new Point(stage.stageWidth/2, stage.stageHeight/2));
                }
                
                var snake:Snake = new Snake(l, _fontLines[i], _colors[i%_colors.length], 5);
                _snakes.push(snake);
                _snakeMaskLayers[i%_snakeMaskLayers.length].addChild(snake);
            }
            
            addEventListener(Event.ENTER_FRAME, changeToChar);
        }
        
        protected function changeToChar(event:Event):void {
             var completeCount:int = 0;
            
            for (var i:int = 0; i < _snakes.length; i++) {
                var snake:Snake = _snakes[i];
                
                if (!snake.completed) {
                    snake.move();
                } else {
                    completeCount++;
                }
            }           
            
            if(completeCount == _snakes.length){
                removeEventListener(Event.ENTER_FRAME, changeToChar);
            }           
        }
        
        private function moveSnake():void {
            addEventListener(Event.ENTER_FRAME, updateMoving);
        }
        
        private function updateMoving(e:Event):void {
            var containsCount:int = 0;
            
            for (var i:int = 0; i < _snakes.length; i++) {
                var snake:Snake = _snakes[i];
                
                if (snake.containsRect(_stageRect)) {
                    containsCount++;
                    
                    snake.move();
                }
            }           
            
            if(containsCount == 0){
                removeEventListener(Event.ENTER_FRAME, updateMoving);
                nextStage();
            }
        }
        
        private function completeDrawing(e:Event):void {
            _lines = _panel.lines;
            Tween24.serial(
                Tween24.prop(_btns).alpha(0),
                Tween24.addChild(stage, _btns),
                Tween24.tween(_btns, 0.3).alpha(1)
            ).play();
        }
        
        private function clickedNextButton(e:MouseEvent):void {
            _nextButton.removeEventListener(MouseEvent.CLICK, clickedNextButton);
            _retrybutton.removeEventListener(MouseEvent.CLICK, clickedRetryButton);
            
            changeToSnake();
        }
        
        private function clickedRetryButton(e:MouseEvent):void {
            Tween24.serial(
                Tween24.tween(_btns, 0.3).alpha(0),
                Tween24.removeChild(_btns)
            ).play();
            _panel.init();
            _panel.start();
        }
        
        private function optimize(line:Vector.<Point>, d:Number):Vector.<Point> {
            var newPoints:Vector.<Point> = new Vector.<Point>();
            var p1:Point = line[0];
            var p2:Point;
            
            for (var i:int = 1; i < line.length; i++) {
                p2 = line[i];
                while (Point.distance(p1, p2) > d) {
                    var dx:Number = p2.x - p1.x;
                    var dy:Number = p2.y - p1.y;
                    var rad:Number = Math.atan2(dy, dx);
                    dx = d * Math.cos(rad);
                    dy = d * Math.sin(rad);
                    
                    p1.x += dx;
                    p1.y += dy;
                    
                    newPoints.push(p1.clone());
                }
            }
            
            return newPoints;
        }

        private function distance(line:Vector.<Point>):Number {
           var dist:Number = 0; 
            for (var i:int = 1; i < line.length; i++) {
                dist += Point.distance(line[i-1], line[i]);
            }
            return dist;
        }
    }
}