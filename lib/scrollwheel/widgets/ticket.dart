import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TicketItem extends StatelessWidget {
  final String barcode;
  final void Function() onTap;
  final Color backgroundColor;
  final DateTime time;
  const TicketItem(
      {super.key,
      required this.barcode,
      required this.onTap,
      required this.backgroundColor,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icon(Icons.arrow_back, color: Colors.white),
                SizedBox(width: 30),
                Text(
                  'Air Ticket',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              children: [
                Positioned.fill(
                  top: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 50),
                    child: ClipPath(
                        clipper: TicketClipper(),
                        child: Container(
                          width: 250,
                          color: Colors.white.withOpacity(0.5),
                        )),
                  ),
                ),
                ClipPath(
                  clipper: TicketClipper(),
                  child: Container(
                    width: 330,
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(29.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ZUH',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'ZHENGZHOU',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.flight_takeoff,
                                    size: 24, color: Colors.grey),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'SHA',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'SHANGHAI',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Passenger',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Jully',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Seat',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '29L',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Date',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      DateFormat("dd MMM yyyy").format(time),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: onTap,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Time',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        DateFormat("HH:mm").format(time),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flight',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'CA1434',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Gate',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'B17',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 0),
                          const Divider(
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 0),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CustomPaint(
                                foregroundPainter: BorderPainter(
                                    frameSFactor: .05, padding: -8),
                                child: SvgPicture.string(barcode)),
                          )
                              // Container(
                              //   height: 50,
                              //   width: 200,
                              //   color: Colors.black,
                              //   child: const Center(
                              //     child: Text(
                              //       'BARCODE',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: MediaQuery.of(context).size.height * 0.47,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: backgroundColor,
                  ),
                ),
                Positioned(
                  right: -20,
                  top: MediaQuery.of(context).size.height * 0.47,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: backgroundColor,
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

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 20.0;
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, size.height * 0.75);
    final holePath = Path();
    holePath.addArc(
        Rect.fromCircle(center: const Offset(0, 0), radius: 13), 0, 2 * pi);

    path.addPath(holePath, Offset(20, size.height * 0.75));
    path.lineTo(0, radius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BorderPainter extends CustomPainter {
  final double padding;
  final double frameSFactor;

  BorderPainter({
    required this.padding,
    required this.frameSFactor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final frameHWidth = size.width * frameSFactor;

    Paint paint = Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    /// background
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(0, 0, size.width, size.height),
          const Radius.circular(18),
        ),
        paint);

    /// top left
    canvas.drawLine(
      Offset(0 + padding, padding),
      Offset(
        padding + frameHWidth,
        padding,
      ),
      paint..color = Colors.black,
    );

    canvas.drawLine(
      Offset(0 + padding, padding),
      Offset(
        padding,
        padding + frameHWidth,
      ),
      paint..color = Colors.black,
    );

    /// top Right
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding - frameHWidth, padding),
      paint..color = Colors.black,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding, padding + frameHWidth),
      paint..color = Colors.black,
    );

    /// Bottom Right
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding - frameHWidth, size.height - padding),
      paint..color = Colors.black,
    );
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding, size.height - padding - frameHWidth),
      paint..color = Colors.black,
    );

    /// Bottom Left
    canvas.drawLine(
      Offset(0 + padding, size.height - padding),
      Offset(0 + padding + frameHWidth, size.height - padding),
      paint..color = Colors.black,
    );
    canvas.drawLine(
      Offset(0 + padding, size.height - padding),
      Offset(0 + padding, size.height - padding - frameHWidth),
      paint..color = Colors.black,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      true; //based on your use-cases
}
