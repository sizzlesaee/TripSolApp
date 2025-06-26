import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000'; // For emulator use
  static const String apiKey = 'TEST_API_KEY';

  static Future<Map<String, dynamic>> getTripPlan(String place) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tripplan/$place'),
        headers: {'Authorization': 'Bearer $apiKey'},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load trip plan');
      }
    } catch (e) {
      print('API error: $e');
      return {
        'plan': [
          {
            'day': 1,
            'activities': ['City Palace', 'Lake Pichola'],
          },
          {
            'day': 2,
            'activities': ['Fateh Sagar', 'Saheliyon ki Bari'],
          },
          {
            'day': 3,
            'activities': ['Shopping', 'Local food tour'],
          },
        ],
        'total_budget': 4000,
        'travel_mode': 'Train',
      };
    }
  }

  static Future<void> saveItinerary(Map<String, dynamic> itinerary) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/saveItinerary'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode(itinerary),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save itinerary');
      }
    } catch (e) {
      print('Mock save error: $e');
    }
  }

  static Future<List<Place>> getRecommendedPlaces() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recommendations'),
        headers: {'Authorization': 'Bearer $apiKey'},
      );
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((item) => Place.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load recommendations');
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
      return [
        Place(
          title: 'Udaipur',
          description: 'The City of Lakes',
          imageUrl: 'https://example.com/udaipur.jpg',
        ),
        Place(
          title: 'Goa',
          description: 'Beaches, parties, and seafood',
          imageUrl:
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        ),
        Place(
          title: 'Varanasi',
          description: 'Spiritual ghats on the Ganges',
          imageUrl:
              'https://images.unsplash.com/photo-1588244646683-6e4f77b2b6d1',
        ),
      ];
    }
  }

  static Future<Map<String, dynamic>> customizeTripPlan(
    Map<String, dynamic> customizationData,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      "plan": [
        {
          "day": 1,
          "activities": ["City Palace", "Lake Pichola"],
        },
        {
          "day": 2,
          "activities": ["Fateh Sagar Lake", "Saheliyon Ki Bari"],
        },
        {
          "day": 3,
          "activities": ["Shopping", "Boat Ride"],
        },
      ],
      "total_budget": customizationData['budget'],
      "travel_mode": customizationData['travel_mode'],
      "start_date": customizationData['start_date'],
      "end_date": customizationData['end_date'],
    };
  }

  static Future<void> deleteTrip(String place, String user) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteItinerary'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({'place': place, 'user': user}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete itinerary');
    }
  }

  static Future<List<Map<String, dynamic>>> getSavedTrips(
    String userEmail,
  ) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate loading
    return [
      {
        "place": "Udaipur",
        "user": userEmail,
        "plan": [
          {
            "day": 1,
            "activities": ["City Palace", "Lake Pichola"],
          },
          {
            "day": 2,
            "activities": ["Fateh Sagar", "Shopping"],
          },
        ],
        "total_budget": 7000,
        "travel_mode": "Train",
        "start_date": "2025-07-10",
        "end_date": "2025-07-12",
      },
      {
        "place": "Goa",
        "user": userEmail,
        "plan": [
          {
            "day": 1,
            "activities": ["Baga Beach", "Anjuna Beach"],
          },
          {
            "day": 2,
            "activities": ["Fort Agauda", "Arambol Beach"],
          },
        ],
        "total_budget": 8500,
        "travel_mode": "Flight",
        "start_date": "2025-08-05",
        "end_date": "2025-08-07",
      },
    ];
  }
}

class Place {
  final String title;
  final String description;
  final String imageUrl;

  Place({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
