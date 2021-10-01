import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MedidasScreen extends StatelessWidget {
  const MedidasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              height: height - 64,
              child: Image.asset(
                'assets/images/women-silhouette.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: 8,
              left: width * .3,
              child: Text('atualizado em ${DateTime.now()}'),
            ),
            Positioned(
              right: 48,
              top: 48,
              child: Row(
                children: [
                  MeasureLabelWidget(
                    label: 'Altura',
                    value: '170',
                    measure: 'cm',
                  ),
                  SizedBox(width: 16),
                  MeasureLabelWidget(
                    label: 'Peso',
                    value: '70',
                    measure: 'kg',
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              top: 200,
              child: Column(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: CustomPaint(
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: MeasureLabelWidget(
                          label: 'Gordura',
                          value: '170',
                          measure: '',
                        ),
                      ),
                      painter: GradientArcPainter(width: 6),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: CustomPaint(
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: MeasureLabelWidget(
                          label: 'IMC',
                          value: '22',
                          measure: '',
                        ),
                      ),
                      painter: GradientArcPainter(width: 6),
                    ),
                  )
                ],
              ),
            ),
            NestedMeasureWidget(
              top: 130,
              left: 0,
              width: width * .5,
              label: 'Pescoço',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: 130 + 40,
              left: 0,
              width: width * .7,
              label: 'Peito',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: 130 + 80,
              left: 40,
              width: width * .4,
              label: 'Bíceps',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: 130 + 120,
              left: 0,
              width: width * .7,
              label: 'Cintura',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: 130 + 160,
              left: 0,
              width: width * .5,
              label: 'Quadril',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: 130 + 240,
              left: 0,
              width: width * .7,
              label: 'Coxa',
              value: '95',
              measure: ' cm',
            ),
            NestedMeasureWidget(
              top: 130 + 340,
              left: 0,
              width: width * .5,
              label: 'Panturrilha',
              value: '95',
              measure: ' cm',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class NestedMeasureWidget extends StatelessWidget {
  NestedMeasureWidget({
    Key? key,
    required this.width,
    this.top = 0,
    this.left = 0,
    required this.label,
    required this.value,
    this.measure = '',
  }) : super(key: key);

  final double width;
  final double top;
  final double left;
  final String label;
  final String value;
  final String measure;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8),
                child: DottedLine(
                  dashGapLength: 8,
                ),
              ),
            ),
            MeasureLabelWidget(
              label: '$label',
              value: '$value',
              measure: '$measure',
            ),
          ],
        ),
      ),
    );
  }
}

class MeasureLabelWidget extends StatelessWidget {
  final String label;
  final String value;
  final String measure;

  const MeasureLabelWidget({
    Key? key,
    required this.label,
    required this.value,
    this.measure = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$label'),
        RichText(
          text: TextSpan(
            text: '$value',
            style: TextStyle(fontSize: 36, color: Colors.black),
            children: [
              TextSpan(
                text: ' $measure',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GradientArcPainter extends CustomPainter {
  const GradientArcPainter({
    required this.width,
  }) : super();

  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: 3 * math.pi / 2,
      endAngle: 7 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: [
        Colors.green,
        Colors.red,
        Colors.blue,
      ],
    );

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = math.pi;
    final sweepAngle = math.pi * 1.5;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
