import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WaterSensor extends StatefulWidget {
  final String Datapath;
  const WaterSensor({super.key, required this.Datapath});

  @override
  State<WaterSensor> createState() => _WaterSensorState();
}

class _WaterSensorState extends State<WaterSensor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Sensor History')
            .orderBy('timestampIST', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  // space at the top
                  const SizedBox(height: 10),
                  // main table
                  Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      _buildHeaderRow(),
                      ...docs.map((doc) {
                        final time = doc['formattedTime'].toString();
                        final waterLevel =
                            doc[widget.Datapath]?.toString() ?? 'N/A';
                        return _buildDataRow(time, waterLevel);
                      }).toList(),
                    ],
                  ),
                  // space at end of page
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildHeaderCell("Time", Colors.blue),
        _buildHeaderCell("Water Level", Colors.red),
      ],
    );
  }

  TableRow _buildDataRow(String time, String waterLevel) {
    return TableRow(
      children: [
        _buildDataCell(time, Colors.blue),
        _buildDataCell(waterLevel, Colors.red),
      ],
    );
  }

  Widget _buildHeaderCell(String text, Color color) {
    return Container(
      color: color.withOpacity(0.3),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, Color color) {
    return Container(
      color: color.withOpacity(0.1),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
