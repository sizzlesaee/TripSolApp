import 'package:flutter/material.dart';
import '../services/api_services.dart';

class PlaceDetailsPage extends StatefulWidget {
  final String placeName;

  const PlaceDetailsPage({super.key, required this.placeName});

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  Map<String, dynamic> tripPlan = {};
  bool isLoading = true;
  bool _isSaving = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchTripPlan();
  }

  Future<void> fetchTripPlan() async {
    try {
      final plan = await ApiService.getTripPlan(widget.placeName);
      setState(() {
        tripPlan = plan;
        isLoading = false;
      });
    } catch (e) {
      print('Trip plan fetch error: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch trip plan. Please try again later.';
      });
    }
  }

  void saveItinerary() async {
    setState(() => _isSaving = true);

    final data = {
      'place': widget.placeName,
      // Replace with dynamic user later
      'user': 'hasini@gmail.com',
      'plan': tripPlan,
    };

    try {
      await ApiService.saveItinerary(data);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Trip has been saved successfully!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Save error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error saving trip.")));
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Widget buildLoadingPlaceholder() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final planList = tripPlan['plan'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(widget.placeName)),
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildLoadingPlaceholder(),
            )
          : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchTripPlan,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    "Trip Plan",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  ...planList.map((day) {
                    return ListTile(
                      title: Text("Day ${day['day']}"),
                      subtitle: Text((day['activities'] as List).join(", ")),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  if (tripPlan.containsKey('total_budget'))
                    Text("Budget: ₹${tripPlan['total_budget']}"),
                  if (tripPlan.containsKey('travel_mode'))
                    Text("Travel Mode: ${tripPlan['travel_mode']}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isSaving ? null : saveItinerary,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text("Save Trip"),
                  ),
                ],
              ),
            ),
    );
  }
}
