import 'package:flutter/material.dart';
import '../models/exhibition_model.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import 'exhibition_detail_screen.dart';

class ExhibitionScreen extends StatefulWidget {
  const ExhibitionScreen({super.key});

  @override
  State<ExhibitionScreen> createState() => _ExhibitionScreenState();
}

class _ExhibitionScreenState extends State<ExhibitionScreen> {
  List<ExhibitionModel> _exhibitions = [];
  late ChallengeModel _challenge;
  bool _hasJoinedChallenge = false;

  @override
  void initState() {
    super.initState();
    _exhibitions = MockDataService.getMockExhibitions();
    _challenge = MockDataService.getCurrentChallenge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '影展',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: AppTheme.gray900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'EXHIBITION HALL',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.gray400,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ..._exhibitions.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: _ExhibitionCard(exhibition: entry.value),
                    );
                  }),
                  _ChallengeCard(
                    challenge: _challenge,
                    hasJoined: _hasJoinedChallenge,
                    onJoin: () {
                      setState(() {
                        _hasJoinedChallenge = !_hasJoinedChallenge;
                      });
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExhibitionCard extends StatelessWidget {
  final ExhibitionModel exhibition;

  const _ExhibitionCard({required this.exhibition});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ExhibitionDetailScreen(exhibition: exhibition),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    exhibition.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: AppTheme.gray100),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        exhibition.isOngoing ? 'Ongoing' : 'Ended',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppTheme.gray900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exhibition.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Curator: ${exhibition.curator} • ${exhibition.participants} Artists',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.gray500,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.gray100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.arrow_forward, size: 16, color: AppTheme.gray700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final ChallengeModel challenge;
  final bool hasJoined;
  final VoidCallback onJoin;

  const _ChallengeCard({
    required this.challenge,
    required this.hasJoined,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.gray900,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, size: 32, color: AppTheme.yellow500),
          const SizedBox(height: 12),
          const Text(
            '本周摄影挑战',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '主题：【${challenge.title}】\n${challenge.description}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.gray400,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '剩余 ${challenge.daysLeft} 天',
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.gray500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onJoin,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              decoration: BoxDecoration(
                color: hasJoined ? AppTheme.gray700 : AppTheme.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                hasJoined ? 'JOINED ✓' : 'JOIN CHALLENGE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: hasJoined ? AppTheme.gray300 : AppTheme.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
