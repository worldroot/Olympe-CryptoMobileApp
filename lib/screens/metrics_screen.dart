import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olympe/components/glassmorphism.dart';
import 'package:olympe/components/snackbar.dart';
import 'package:olympe/models/exposed_global_metrics_model.dart';
import 'package:olympe/repository/repository.dart';
import 'package:olympe/statics.dart';

class MetricsScreen extends StatefulWidget {
  const MetricsScreen({Key? key}) : super(key: key);

  @override
  State<MetricsScreen> createState() => _MetricsScreenState();
}

class _MetricsScreenState extends State<MetricsScreen>
    with AutomaticKeepAliveClientMixin<MetricsScreen> {
  @override
  bool get wantKeepAlive => true;
  final Repository repository = Repository();
  int touchedIndex = 0;
  Data? globalMetricsData;
  @override
  void initState() {
    super.initState();
    fetchGlobalMetrics();
  }

  fetchGlobalMetrics() {
    repository.getGlobalMetrics().then((list) {
      setState(() {
        globalMetricsData = list.data;
        isLoading = false;
      });
    });
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(color: Palette.primaryColor),
          )
        : Stack(
            children: [
              RefreshIndicator(
                backgroundColor: Colors.transparent,
                color: Palette.primaryColor,
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  fetchGlobalMetrics();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(bottom: 5, top: 10),
                          child: Text(
                            "Total Market Cap",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 17),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(bottom: 5, top: 10),
                          child: Text(
                            " ${globalMetricsData!.quote!.uSD!.totalMarketCap} \$"
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        margin: const EdgeInsets.only(bottom: 5, top: 40),
                        child: const Text(
                          "Global Metrics",
                          style: TextStyle(
                              fontFamily: "Oswald",
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      GlassMorphism(
                        color: Colors.transparent,
                        blur: 10,
                        myWidth: 280,
                        myHeight: double.infinity,
                        opacity: 0.2,
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 0,
                                sections: showingSections()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xfff8b250), //0xff0293ee
            value: globalMetricsData!.btcDominance,
            title: "${globalMetricsData!.btcDominance?.ceilToDouble()} %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/icon/btc.png",
              size: widgetSize,
              borderColor: const Color(0xfff8b250), //0xff0293ee
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff0293ee), //0xfff8b250
            value: globalMetricsData!.ethDominance,
            title: "${globalMetricsData!.ethDominance?.ceilToDouble()} %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/icon/eth.png",
              size: widgetSize,
              borderColor: const Color(0xff0293ee), //0xfff8b250
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 100 -
                (globalMetricsData!.btcDominance! +
                    globalMetricsData!.ethDominance!),
            title:
                'Others ${100 - (globalMetricsData!.btcDominance! + globalMetricsData!.ethDominance!).ceilToDouble()} %',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/icon/dollar.png",
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3: // Not used for now
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              "assets/crypto-logos/128/icon/btc.png",
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatefulWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  State<_Badge> createState() => _BadgeState();
}

class _BadgeState extends State<_Badge> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.transparent,
            offset: const Offset(3, 3),
            blurRadius: 0.2,
          ),
        ],
      ),
      padding: EdgeInsets.all(widget.size * .15),
      child: Center(
          child: CachedNetworkImage(
        imageUrl: ((widget.svgAsset).toLowerCase()),
        fit: BoxFit.contain,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            SvgPicture.asset('assets/icons/dollar.svg'),
      )),
    );
  }
}
