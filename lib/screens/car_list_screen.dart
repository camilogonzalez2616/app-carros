import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../providers/auth_provider.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final carProvider = Provider.of<CarProvider>(context, listen: false);
      if (authProvider.token != null) {
        carProvider.fetchCars(authProvider.token!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Mis Carros Eléctricos")),
      body:
          carProvider.cars.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: carProvider.cars.length,
                itemBuilder: (ctx, index) {
                  final car = carProvider.cars[index];
                  return ListTile(
                    leading: Icon(Icons.directions_car, size: 40),
                    title: Text("Placa: ${car.placa}"),
                    subtitle: Text("Conductor: ${car.conductor}"),
                  );
                },
              ),
    );
  }
}
