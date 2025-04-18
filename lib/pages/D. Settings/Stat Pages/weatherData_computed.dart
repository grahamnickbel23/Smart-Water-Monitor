import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WeatherdataComputed extends StatelessWidget{
  const WeatherdataComputed ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Weather Data", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Weather History')
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
                        final humidity =
                            doc["humidity"]?.toString() ?? 'N/A';
                        final temperature =
                            doc["temperature"]?.toString() ?? 'N/A';
                        return _buildDataRow(time, humidity, temperature);
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
        _buildHeaderCell("Humidity", Colors.green),
        _buildHeaderCell("Temperature", Colors.red),
      ],
    );
  }

  TableRow _buildDataRow(String time, String humidity, String temperature) {
    return TableRow(
      children: [
        _buildDataCell(time, Colors.blue),
        _buildDataCell(humidity, Colors.green),
        _buildDataCell(temperature, Colors.red),
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
