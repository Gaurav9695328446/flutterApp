import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'dart:async';
import './ticket_data.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

class Ticket {
  Future<String> get localPath async {
    Directory dir = new Directory('C:/Users/gaura/Documents');
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;

    return File('$path/Projects/FlutterApp/ticket.pdf');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(TicketData ticketData) async {
    final Uint8List fontData =
        File('assets/OpenSans-Regular.ttf').readAsBytesSync();
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    final String dateData =
        new DateFormat('dd MMM yyyy').format(new DateTime.now()).toString();
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) => pw.Center(
        child: pw.ListView(
          children: <pw.Widget>[
            pw.Center(
              child: pw.Text('***National Highways Authority Of India***',
                  style: pw.TextStyle(fontSize: 9, font: ttf)),
            ),
            pw.Text('Toll Collected By',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.DecoratedBox(
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('#000000')),
              child: pw.Text('  NATIONAL HIGHWAY AUTHORITY OF INDIA  ',
                  style: pw.TextStyle(
                      color: PdfColor.fromHex('#ffffff'),
                      fontSize: 9,
                      font: ttf)),
            ),
            pw.Text('For kharar Ludhiana Road',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.Text(
                '-------------------------------------------------------------',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.Text(
                '-------------------------------------------------------------',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.Table(
              children: [
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Ticket No',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.ticketNo}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Booth & Op. No',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.boothInfo}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Date & Time',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.dateInfo}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Vehicle No',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.vehicleNo}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Vehicle Type',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.vehicleType}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Journey Type',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.journeyType}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Fee',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(': ${ticketData.fee}',
                            style: pw.TextStyle(fontSize: 10, font: ttf))
                      ]),
                ]),
              ],
            ),
            pw.Text('${ticketData.feeInWords}',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.Text(
                '-------------------------------------------------------------',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.Text(
                '-------------------------------------------------------------',
                style: pw.TextStyle(fontSize: 10, font: ttf)),
            pw.Text('WISH YOU SAFE & HAPPY JOURNEY',
                style: pw.TextStyle(fontSize: 9, font: ttf)),
            pw.Text('All fee payments via FASTag only',
                style: pw.TextStyle(fontSize: 9, font: ttf)),
            pw.Text('w.e.f $dateData', style: pw.TextStyle(fontSize: 8)),
          ],
        ),
      ),
    ));
    final file = await localFile;
    return file.writeAsBytes(doc.save());
  }
}
