import 'package:crypto_demo/api_service.dart';
import 'package:crypto_demo/crypto_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CryptoModel>> _futureCoins;

  @override
  void initState() {
    super.initState();
    _futureCoins = ApiService.fetchCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Crypto dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<CryptoModel>>(
        future: _futureCoins,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No coin data available', style: TextStyle(color: Colors.white)),
            );
          }

          final coins = snapshot.data!;
          final topGainers = coins.take(9).toList();
          final topLosers = coins.reversed.take(9).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // news
                Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[900],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      'Top Crypto News Coming Soon...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 📈 Top Gainers
                const Text('Top Gainers', style: TextStyle(color: Colors.greenAccent, fontSize: 18)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: topGainers.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final coin = topGainers[index];
                      return _buildCoinTile(coin);
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // 📉 Top Losers
                const Text('Top Losers', style: TextStyle(color: Colors.redAccent, fontSize: 18)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: topLosers.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final coin = topLosers[index];
                      return _buildCoinTile(coin);
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // 📊 Global Market Cap Placeholder
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Global Market Cap', style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Data coming soon...', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoinTile(CryptoModel coin) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          coin.iconUrl.isNotEmpty
              ? Image.network(
                  coin.iconUrl,
                  height: 40,
                  width: 40,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.error, color: Colors.white),
                )
              : const Icon(Icons.currency_bitcoin, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            coin.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            '\$${coin.price.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
