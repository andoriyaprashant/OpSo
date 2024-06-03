import 'package:flutter/material.dart';

class GSSOCScreen extends StatelessWidget {
  const GSSOCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Girl Script Summer of Code'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              ),
              onChanged: (value) {
                // Handle search input
              },
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YearButton(
                year: '2021',
                url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
              ),
              YearButton(
                year: '2022',
                url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YearButton(
                year: '2023',
                url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
              ),
              YearButton(
                year: '2024',
                url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // launch('https://example.com/projects'); // Replace with actual URL
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 226, 230, 120), // Set button color
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
            child: const Text('View Projects'),
          ),
        ],
      ),
    );
  }
}

class YearButton extends StatelessWidget {
  final String year;
  final String url;

  const YearButton({super.key, required this.year, required this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ignore: deprecated_member_use
        // launch(url);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 172, 207, 236), // Set button color
      ),
      child: Text(year),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: GSSOCScreen(),
  ));
}


