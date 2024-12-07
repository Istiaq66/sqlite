import 'package:flutter/material.dart';
import 'package:sqlite/models/scholar_model.dart';


// Scholar Details Page (similar to previous implementation)
class ScholarDetailsPage extends StatelessWidget {
  final Scholar scholar;

  const ScholarDetailsPage({super.key, required this.scholar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scholar Details'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('ID', scholar.id.toString()),
                const SizedBox(height: 10),
                _buildDetailRow('Famous Name', scholar.famousName),
                const SizedBox(height: 10),
                _buildDetailRow('Lived In', scholar.livedIn),
                if (scholar.bornOn.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _buildDetailRow('Born On', scholar.bornOn),
                ],
                if (scholar.diedOn.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _buildDetailRow('Died On', scholar.diedOn),
                ],
                if (scholar.nickName.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _buildDetailRow('Nickname', scholar.nickName),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Scholars List Page
class ScholarsListPage extends StatelessWidget {

  final List<Scholar> scholars;

  const ScholarsListPage({super.key,required this.scholars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scholars List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: scholars.length,
        itemBuilder: (context, index) {
          final scholar = scholars[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                scholar.famousName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              subtitle: Text(
                'Lived in: ${scholar.livedIn}',
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScholarDetailsPage(scholar: scholar),
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