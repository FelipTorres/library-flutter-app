import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca de Livros'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite o título ou autor',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      provider.search(_controller.text);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    provider.clear();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (provider.isLoading) const CircularProgressIndicator(),
            if (provider.error.isNotEmpty)
              Text(provider.error, style: const TextStyle(color: Colors.red)),
            if (!provider.isLoading && provider.books.isEmpty && provider.error.isEmpty)
              const Text('Nenhum resultado. Tente uma busca!'),
            if (provider.books.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    final book = provider.books[index];
                    return ListTile(
                      leading: Image.network(book.coverUrl, width: 50, fit: BoxFit.cover),
                      title: Text(book.title),
                      subtitle: Text(book.authors.join(', ')),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}