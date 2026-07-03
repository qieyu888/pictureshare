import 'package:flutter/material.dart';
import '../models/exhibition_model.dart';
import '../theme/app_theme.dart';
import '../utils/share_utils.dart';

class ExhibitionDetailScreen extends StatefulWidget {
  final ExhibitionModel exhibition;

  const ExhibitionDetailScreen({super.key, required this.exhibition});

  @override
  State<ExhibitionDetailScreen> createState() => _ExhibitionDetailScreenState();
}

class _ExhibitionDetailScreenState extends State<ExhibitionDetailScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          // 封面 + AppBar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppTheme.white,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_left, color: AppTheme.white, size: 22),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.ios_share, color: AppTheme.white, size: 18),
                ),
                onPressed: () => ShareUtils.showShareSheet(
                  context,
                  title: widget.exhibition.title,
                  subtitle: '策展人：${widget.exhibition.curator}',
                  onShare: () => ShareUtils.shareExhibition(context, widget.exhibition),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.exhibition.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppTheme.gray100),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: widget.exhibition.isOngoing
                            ? Colors.green.withValues(alpha: 0.9)
                            : Colors.grey.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.exhibition.isOngoing ? '● 进行中' : '已结束',
                        style: const TextStyle(
                          color: AppTheme.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    widget.exhibition.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray900,
                      letterSpacing: -0.5,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 策展人 + 关注
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppTheme.gray100,
                        child: Icon(Icons.person, size: 18, color: AppTheme.gray400),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.exhibition.curator,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.gray900,
                              ),
                            ),
                            const Text(
                              '策展人',
                              style: TextStyle(fontSize: 11, color: AppTheme.gray400),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isFollowing = !_isFollowing),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: _isFollowing ? AppTheme.gray100 : AppTheme.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _isFollowing ? '已关注' : '关注',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _isFollowing ? AppTheme.gray700 : AppTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 统计数据
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.gray50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _StatItem(
                          value: '${widget.exhibition.participants}',
                          label: '参展艺术家',
                        ),
                        _Divider(),
                        _StatItem(
                          value: '${widget.exhibition.works.length}',
                          label: '精选作品',
                        ),
                        _Divider(),
                        _StatItem(
                          value: widget.exhibition.isOngoing ? '进行中' : '已结束',
                          label: '展览状态',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 简介
                  const Text(
                    '关于本次影展',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.exhibition.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.gray600,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 标签
                  if (widget.exhibition.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.exhibition.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.gray100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '# $tag',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.gray700,
                          ),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // 精选作品标题
                  Row(
                    children: [
                      const Icon(Icons.grid_view_rounded, size: 18, color: AppTheme.gray900),
                      const SizedBox(width: 8),
                      const Text(
                        '精选作品',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray900,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.exhibition.works.length} 件',
                        style: const TextStyle(fontSize: 12, color: AppTheme.gray400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),

          // 作品网格
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: widget.exhibition.works.length,
              itemBuilder: (context, index) {
                final work = widget.exhibition.works[index];
                return _WorkCard(work: work);
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.gray900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppTheme.gray400),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: AppTheme.gray200);
  }
}

class _WorkCard extends StatelessWidget {
  final ExhibitionWorkModel work;

  const _WorkCard({required this.work});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showWorkDetail(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              work.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppTheme.gray100),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.65)],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    work.title,
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          work.authorAvatar,
                          width: 16,
                          height: 16,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 16,
                            height: 16,
                            color: AppTheme.gray400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          work.authorName,
                          style: TextStyle(
                            color: AppTheme.white.withValues(alpha: 0.8),
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.favorite, size: 10, color: AppTheme.white),
                      const SizedBox(width: 3),
                      Text(
                        '${work.likes}',
                        style: TextStyle(
                          color: AppTheme.white.withValues(alpha: 0.8),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWorkDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkDetailSheet(work: work),
    );
  }
}

class _WorkDetailSheet extends StatelessWidget {
  final ExhibitionWorkModel work;

  const _WorkDetailSheet({required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.gray200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // 图片
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          work.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: AppTheme.gray100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          work.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.gray900,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                work.authorAvatar,
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 36,
                                  height: 36,
                                  color: AppTheme.gray100,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    work.authorName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.gray900,
                                    ),
                                  ),
                                  const Text(
                                    '参展艺术家',
                                    style: TextStyle(fontSize: 11, color: AppTheme.gray400),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.favorite_border, size: 18, color: AppTheme.gray700),
                                const SizedBox(width: 4),
                                Text(
                                  '${work.likes}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.gray700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
