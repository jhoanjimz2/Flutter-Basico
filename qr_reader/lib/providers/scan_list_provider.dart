


import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/providers/providers.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan( String valor ) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el id de la base de datos al modelo
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
    }

    notifyListeners();
  }

  cargarScans() async {
    final _scans = await DBProvider.db.getTodosLosScans();
    scans = [..._scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scAns = await DBProvider.db.getScansPorTipo(tipo);
    scans = [...scAns];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }

}