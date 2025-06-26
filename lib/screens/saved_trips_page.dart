import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_services.dart';
import 'trip_detail_page.dart';

class SavedTripsPage extends StatefulWidget {
  const SavedTripsPage({super.key});

  @override
  State<SavedTripsPage> createState() => _SavedTripsPageState();
}

class _SavedTripsPageState extends State<SavedTripsPage> {
  List<Map<String, dynamic>> _savedTrips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSavedTrips();
  }

  Future<void> fetchSavedTrips() async {
    try {
      final trips = await ApiService.getSavedTrips("hasini@gmail.com");
      setState(() {
        _savedTrips = trips;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching saved trips: $e");
      setState(() => _isLoading = false);
    }
  }

  String formatDate(String iso) {
    final dt = DateTime.tryParse(iso);
    return dt != null ? DateFormat.yMMMd().format(dt) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Saved Trips")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedTrips.isEmpty
          ? const Center(child: Text("No trips saved yet!"))
          : ListView.builder(
              itemCount: _savedTrips.length,
              itemBuilder: (context, index) {
                final trip = _savedTrips[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(trip['place']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dates: ${formatDate(trip['start_date'])} → ${formatDate(trip['end_date'])}",
                        ),
                        Text("Budget: ₹${trip['total_budget']}"),
                        Text("Mode: ${trip['travel_mode']}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripDetailPage(trip: trip),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
