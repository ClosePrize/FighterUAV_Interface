import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:savasan_interface_2024/pages/MapWidget/hss.dart';
import '../../colors.dart';
import '../../remoteService.dart';
import '../AccountsWidget/widgets.dart';
import '../CommandsWidget/commandModels.dart';
import '../TelemetriWidget/telemetry.dart';
import 'MetroLines.dart';
import 'planes.dart';

class MetroLinesPage extends StatefulWidget {
  List<KonumBilgileri> konums;
  List<PlanesTelemetry> enemyPlanesTelemetry;
  List<PlanesTelemetry> parsTelemetry;
  List<HssBilgileri> hssBilgileriList2;
  final Telemetry telemetryInfo;
  QrInf qrInf;

  MetroLinesPage({Key? key, required this.enemyPlanesTelemetry, required this.parsTelemetry, required this.konums, required this.telemetryInfo, required this.qrInf, required this.hssBilgileriList2}) : super(key: key);

  @override
  MetroLinesPageState createState() => MetroLinesPageState();
}

List<PlanesTelemetry> customCoordinates = [
  PlanesTelemetry(id: 1, position: LatLng(36.942314, 35.563323), yaw: 0, alt: 0),
  PlanesTelemetry(id: 2, position: LatLng(36.942673, 35.553363), yaw: 0, alt: 0),
  PlanesTelemetry(id: 3, position: LatLng(36.937683, 35.553324), yaw: 0, alt: 0),
  PlanesTelemetry(id: 4, position: LatLng(36.937864, 35.562873), yaw: 0, alt: 0),
  PlanesTelemetry(id: 5, position: LatLng(36.942314, 35.563323), yaw: 0, alt: 0),
];

class MetroLinesPageState extends State<MetroLinesPage> {

  var controller = MapController(
    location: const LatLng(40.233309, 29.004314),
    zoom: 15,
  );
  var planeCount = 0;
  final stations = <PlanesTelemetry>[];
  final planes = <PlanesTelemetry>[];
  List<Planes>? telem;

  String google(int z, int x, int y) {
    //Google Maps
    final url =
        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
    return url;
  }

  String googleDark(int z, int x, int y) {
    final url =
        'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i$z!2i$x!3i$y!4i256!2m3!1e0!2sm!3i556279080!3m17!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcC52Om9uLHMuZTpsfHAudjpvZmZ8cC5zOi0xMDAscy5lOmwudC5mfHAuczozNnxwLmM6I2ZmMDAwMDAwfHAubDo0MHxwLnY6b2ZmLHMuZTpsLnQuc3xwLnY6b2ZmfHAuYzojZmYwMDAwMDB8cC5sOjE2LHMuZTpsLml8cC52Om9mZixzLnQ6MXxzLmU6Zy5mfHAuYzojZmYwMDAwMDB8cC5sOjIwLHMudDoxfHMuZTpnLnN8cC5jOiNmZjAwMDAwMHxwLmw6MTd8cC53OjEuMixzLnQ6NXxzLmU6Z3xwLmM6I2ZmMDAwMDAwfHAubDoyMCxzLnQ6NXxzLmU6Zy5mfHAuYzojZmY0ZDYwNTkscy50OjV8cy5lOmcuc3xwLmM6I2ZmNGQ2MDU5LHMudDo4MnxzLmU6Zy5mfHAuYzojZmY0ZDYwNTkscy50OjJ8cy5lOmd8cC5sOjIxLHMudDoyfHMuZTpnLmZ8cC5jOiNmZjRkNjA1OSxzLnQ6MnxzLmU6Zy5zfHAuYzojZmY0ZDYwNTkscy50OjN8cy5lOmd8cC52Om9ufHAuYzojZmY3ZjhkODkscy50OjN8cy5lOmcuZnxwLmM6I2ZmN2Y4ZDg5LHMudDo0OXxzLmU6Zy5mfHAuYzojZmY3ZjhkODl8cC5sOjE3LHMudDo0OXxzLmU6Zy5zfHAuYzojZmY3ZjhkODl8cC5sOjI5fHAudzowLjIscy50OjUwfHMuZTpnfHAuYzojZmYwMDAwMDB8cC5sOjE4LHMudDo1MHxzLmU6Zy5mfHAuYzojZmY3ZjhkODkscy50OjUwfHMuZTpnLnN8cC5jOiNmZjdmOGQ4OSxzLnQ6NTF8cy5lOmd8cC5jOiNmZjdmOGQ4OSxzLnQ6NTF8cy5lOmcuZnxwLmM6I2ZmN2Y4ZDg5LHMudDo0fHMuZTpnfHAuYzojZmYwMDAwMDB8cC5sOjE5LHMudDo2fHAuYzojZmYyYjM2Mzh8cC52Om9uLHMudDo2fHMuZTpnfHAuYzojZmYyYjM2Mzh8cC5sOjE3LHMudDo2fHMuZTpnLmZ8cC5jOiNmZjI0MjgyYixzLnQ6NnxzLmU6Zy5zfHAuYzojZmYyNDI4MmIscy50OjZ8cy5lOmx8cC52Om9mZixzLnQ6NnxzLmU6bC50fHAudjpvZmYscy50OjZ8cy5lOmwudC5mfHAudjpvZmYscy50OjZ8cy5lOmwudC5zfHAudjpvZmYscy50OjZ8cy5lOmwuaXxwLnY6b2Zm!4e0';
    return url;
  }

  double clamp(double x, double min, double max) {
    if (x < min) x = min;
    if (x > max) x = max;

    return x;
  }

  @override
  void initState() {
    enemyPlanesTelemetry = widget.enemyPlanesTelemetry;
    parsTelemetry = widget.parsTelemetry;
    var all = _lines.expand((element) => element.stations).toSet();
    stations.addAll(all);

    super.initState();
  }

  void _gotoDefault() {
    controller.center = const LatLng(35.68, 51.41);
    setState(() {});
  }

  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => _onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: _onScaleStart,
            onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta.dy / -1000.0;
                  final zoom = clamp(controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  // Tile Layer (Google Maps background)
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();

                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }

                      x %= tilesInZoom;
                      y %= tilesInZoom;
                      return CachedNetworkImage(
                        imageUrl: googleDark(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // Paint the polyline (Metro lines)
                  CustomPaint(
                    painter: PolylinePainter(transformer),
                  ),
                  // Phantom marker (player's plane)
                  // QR marker
                  _buildQRMarker(QrLatLon(position: LatLng(widget.qrInf.qrEnlem, widget.qrInf.qrBoylam)), Colors.black, transformer),
                  _buildPhantomMarker(
                    PhantomTelemetry(
                      position: LatLng(widget.telemetryInfo.lat, widget.telemetryInfo.lon),
                    ),
                    Colors.blue,
                    widget.konums,
                    transformer,
                    icon: Icons.airplanemode_on,
                  ),
                  // HSS markers (newly added)
                  ...widget.hssBilgileriList2
                      .map(
                        (e) => _buildHSSMarker(e, Colors.red, widget.hssBilgileriList2, transformer),
                  )
                      .toList(),
                  // Plane markers (enemy planes)
                  ...widget.enemyPlanesTelemetry
                      .map(
                        (e) => _buildStationMarker(e, Colors.red, widget.konums, transformer),
                  )
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildStationMarker(
      PlanesTelemetry station,
      Color color,
      List<KonumBilgileri> konumBilgileri,
      MapTransformer transformer, {
        IconData icon = Icons.airplanemode_on,
      }) {
    var pos = transformer.toOffset(station.position);

    return Positioned(
      left: pos.dx - 12,
      top: pos.dy - 12,
      width: 24,
      height: 24,
      child: GestureDetector(
        child: RotatedIcon(
          icon: icon,
          degrees: station.yaw,
          size: 25,
          color: Colors.red,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Plane id: ${station.id} \nLat: ${station.position.latitude} \nLon: ${station.position.longitude} \nYönelme: ${station.yaw}\nAlt: ${station.alt}'),
                    SizedBox(height: 15,),
                    connectButton(context, thirdPalette1, "Takip", 100, 40, () async {
                      Navigator.pop(context);
                      await RemoteService().sendTargetNumber(station.id);
                    }),
                  ],
              )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhantomMarker(
      PhantomTelemetry phantom,
      Color color,
      List<KonumBilgileri> konumBilgileri,
      MapTransformer transformer, {
        IconData icon = Icons.airplanemode_on,
      }) {
    var pos = transformer.toOffset(phantom.position);

    return Positioned(
      left: pos.dx - 12,
      top: pos.dy - 12,
      width: 24,
      height: 24,
      child: GestureDetector(
        child: RotatedIcon(
          icon: icon,
          degrees: widget.telemetryInfo.heading,
          color: Colors.blue,
          size: 25,// Rotation in degrees
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Row(children: [Text('Phantom',style: TextStyle(fontSize: 22),)],mainAxisAlignment: MainAxisAlignment.center,),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQRMarker(
      QrLatLon qr,
      Color color,
      MapTransformer transformer, {
        IconData icon = Icons.qr_code,
      }) {
    var pos = transformer.toOffset(qr.position);

    return Positioned(
      left: pos.dx - 12,
      top: pos.dy - 12,
      width: 24,
      height: 24,
      child: Icon(icon, size: 25, color: color,)
    );
  }

  Widget _buildHSSMarker(
      HssBilgileri hss, // Using HssBilgileri directly
      Color color,
      List<HssBilgileri> hssBilgileri,
      MapTransformer transformer) {

    // Get the position of the HSS marker
    var pos = transformer.toOffset(LatLng(hss.hssEnlem, hss.hssBoylam));

    // Calculate radius in pixels based on hssYaricap (in meters) and the current map zoom level
    double radiusInPixels = metersToPixels(hss.hssYaricap, hss.hssEnlem, transformer.controller.zoom);

    return Positioned(
      left: pos.dx - radiusInPixels, // Position based on the circle's radius
      top: pos.dy - radiusInPixels,
      child: GestureDetector(
        onTap: () {
          // Show dialog when HSS marker is tapped
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('HSS ID: ${hss.id}'),
                  Text('Lat: ${hss.hssEnlem}, Lon: ${hss.hssBoylam}'),
                  Text('Radius: ${hss.hssYaricap}m'),
                ],
              ),
            ),
          );
        },
        child: Container(
          width: radiusInPixels * 2, // Diameter of the circle
          height: radiusInPixels * 2, // Diameter of the circle
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.3), // Semi-transparent fill color
            border: Border.all(
              color: color, // Border color
              width: 2.0,   // Border width
            ),
          ),
        ),
      ),
    );
  }

  /// Helper function to convert meters to pixels based on zoom and latitude
  double metersToPixels(double meters, double latitude, double zoom) {
    const earthCircumference = 40075017.0; // meters
    const pixelsPerTile = 256.0;

    // Meters per pixel calculation
    double metersPerPixel = (earthCircumference * cos(latitude * pi / 180)) / (pow(2, zoom) * pixelsPerTile);

    // Convert meters to pixels
    return meters / metersPerPixel;
  }

}

class PolylinePainter extends CustomPainter {
  PolylinePainter(this.transformer);

  final MapTransformer transformer;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 4;

    for (var line in _lines) {
      paint.color = line.color;

      for (int i = 0; i < line.stations.length - 1; i++) {
        var p1 = transformer.toOffset(line.stations[i].position);
        var p2 = transformer.toOffset(line.stations[i + 1].position);

        var dash = line.stations[i].underConstruction ||
            line.stations[i + 1].underConstruction;

        if (dash) {
          var dir = (p2 - p1);

          var dist = dir.distance;
          var dirn = dir / dist;

          var count = (dist / 16).ceil();
          var step = dist / count;

          for (int i = 0; i < count; i++) {
            var c = p1 + dirn * (step * i.toDouble());
            canvas.drawCircle(c, 3, paint);
          }
        } else {
          canvas.drawLine(p1, p2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(PolylinePainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(PolylinePainter oldDelegate) => false;
}

var enemyPlanesTelemetry = <PlanesTelemetry>[];
var parsTelemetry = <PlanesTelemetry>[];
var hssinfs = <HSSData>[];

final parsLine = MetroLine(
    name: 'Line 1', color: Colors.transparent, stations: enemyPlanesTelemetry);

final enemyLine = MetroLine(
    name: 'Line 2', color: Colors.transparent, stations: parsTelemetry);

final customLine = MetroLine(
  name: 'Alan Sınırları',
  color: Colors.black, // Choose your line color
  stations: customCoordinates,
);

final _lines = [parsLine,enemyLine,customLine];

class MetroLine {
  MetroLine({
    required this.name,
    required this.color,
    required this.stations,
  });

  final String name;
  final Color color;
  final List<PlanesTelemetry> stations;
}

class PlanesTelemetry {
  PlanesTelemetry({
    required this.id,
    required this.position,
    required this.yaw,
    required this.alt,
    this.underConstruction = false,
  });

  final int id;
  final LatLng position;
  final bool underConstruction;
  final double yaw;
  final double alt;
}

class HSSData {
  HSSData({
    required this.id,
    required this.position,
    required this.yaricap,
    this.underConstruction = false,
  });

  final int id;
  final LatLng position;  // LatLng for the position
  final bool underConstruction;
  final double yaricap;  // The radius (hssYaricap) from HssBilgileri
}


class PhantomTelemetry {
  PhantomTelemetry({
    required this.position,
  });

  final LatLng position;
}

class QrLatLon {
  QrLatLon({
    required this.position,
  });

  final LatLng position;
}

class RotatedIcon extends StatelessWidget {
  final IconData icon;
  final double degrees;
  final double size;
  final Color color;

  RotatedIcon({required this.icon, required this.degrees, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    // Convert degrees to radians
    double radians = degrees * (3.14 / 180);

    return Transform.rotate(
      angle: radians,
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}