import '../models/post_model.dart';
import '../models/exhibition_model.dart';
import '../models/explore_model.dart';
import '../models/user_model.dart';

class MockDataService {
  static List<PostModel> getMockPosts() {
    return [
      PostModel(
        id: '1',
        userId: '1',
        userName: '林风',
        userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
        imageUrl: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800',
        caption: '清晨的阿尔卑斯山，第一缕阳光穿透云雾。那一刻，世界仿佛只剩下呼吸声。',
        likes: 1240,
        inspirations: 89,
        timeAgo: '2小时前',
        comments: [
          const CommentModel(
            id: 'c1',
            userName: '晓月',
            content: '构图绝了，这种影调真的让人心安，光影的颗粒感恰到好处。',
            timeAgo: '1小时前',
          ),
        ],
      ),
      PostModel(
        id: '2',
        userId: '2',
        userName: '苏影',
        userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
        imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
        caption: '赛博朋克风格的街头摄影，霓虹与雨水的交织。这种迷失感正是大都市的魅力所在。',
        likes: 856,
        inspirations: 45,
        timeAgo: '5小时前',
      ),
      PostModel(
        id: '3',
        userId: '3',
        userName: '荒野猎人',
        userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
        caption: '无人之境的静谧。大自然才是最伟大的摄影师，我只是负责按下快门记录她的低语。',
        likes: 2100,
        inspirations: 156,
        timeAgo: '1天前',
      ),
      PostModel(
        id: '4',
        userId: '4',
        userName: '城市游侠',
        userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
        caption: '街头的故事，每个人都是主角。',
        likes: 678,
        inspirations: 34,
        timeAgo: '3小时前',
      ),
    ];
  }

  static List<ExhibitionModel> getMockExhibitions() {
    return const [
      ExhibitionModel(
        id: '1',
        title: '光影之诗：极简主义影展',
        coverUrl: 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?w=800',
        curator: '光影志编辑部',
        participants: 128,
        description: '极简主义摄影是一种以简洁、纯粹为核心的视觉语言。本次影展汇聚了来自全球128位摄影师的精选作品，探索"少即是多"的美学哲学。',
        tags: ['极简', '黑白', '构图', '留白'],
        works: [
          ExhibitionWorkModel(
            id: 'w1',
            imageUrl: 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?w=600',
            authorName: '林风',
            authorAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            title: '无题 #1',
            likes: 1240,
          ),
          ExhibitionWorkModel(
            id: 'w2',
            imageUrl: 'https://images.unsplash.com/photo-1493397212122-2b85dda8106b?w=600',
            authorName: '苏影',
            authorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            title: '线条之间',
            likes: 856,
          ),
          ExhibitionWorkModel(
            id: 'w3',
            imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600',
            authorName: '荒野猎人',
            authorAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            title: '几何',
            likes: 2100,
          ),
          ExhibitionWorkModel(
            id: 'w4',
            imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600',
            authorName: '城市游侠',
            authorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            title: '静默',
            likes: 678,
          ),
          ExhibitionWorkModel(
            id: 'w5',
            imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=600',
            authorName: '晓月',
            authorAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
            title: '城市留白',
            likes: 934,
          ),
          ExhibitionWorkModel(
            id: 'w6',
            imageUrl: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=600',
            authorName: '远山',
            authorAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
            title: '晨雾',
            likes: 1567,
          ),
        ],
      ),
      ExhibitionModel(
        id: '2',
        title: '人间烟火：街头纪实专题',
        coverUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
        curator: '苏影',
        participants: 256,
        description: '街头摄影是最真实的人文记录。本次专题收录了256位摄影师在世界各地街头捕捉的珍贵瞬间，展现城市生活的温度与烟火气。',
        tags: ['街拍', '纪实', '人文', '城市'],
        works: [
          ExhibitionWorkModel(
            id: 'w7',
            imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=600',
            authorName: '苏影',
            authorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            title: '霓虹夜雨',
            likes: 2340,
          ),
          ExhibitionWorkModel(
            id: 'w8',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=600',
            authorName: '城市游侠',
            authorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            title: '街角',
            likes: 1890,
          ),
          ExhibitionWorkModel(
            id: 'w9',
            imageUrl: 'https://images.unsplash.com/photo-1507502707541-f369a3b18502?w=600',
            authorName: '林风',
            authorAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            title: '行人',
            likes: 1120,
          ),
          ExhibitionWorkModel(
            id: 'w10',
            imageUrl: 'https://images.unsplash.com/photo-1475721027785-f74eccf3734a?w=600',
            authorName: '荒野猎人',
            authorAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            title: '市集',
            likes: 765,
          ),
        ],
      ),
    ];
  }

  static ChallengeModel getCurrentChallenge() {
    return const ChallengeModel(
      id: '1',
      title: '孤独的线条',
      description: '用相机捕捉城市中被忽视的几何美感。',
      daysLeft: 5,
    );
  }

  static List<TopicModel> getTrendingTopics() {
    return const [
      TopicModel(id: '1', name: '# 胶片复兴计划', postCount: 1234),
      TopicModel(id: '2', name: '# 极简建筑美学', postCount: 890),
      TopicModel(id: '3', name: '# 黄金时刻拍摄技巧', postCount: 567),
      TopicModel(id: '4', name: '# 扫街的艺术', postCount: 432),
      TopicModel(id: '5', name: '# 这种构图怎么看', postCount: 321),
    ];
  }

  static List<FeaturedThemeModel> getFeaturedThemes() {
    return const [
      FeaturedThemeModel(
        id: '1',
        name: '雨中霓虹',
        imageUrl: 'https://images.unsplash.com/photo-1507502707541-f369a3b18502?w=300',
        count: '1.2k',
      ),
      FeaturedThemeModel(
        id: '2',
        name: '山野回响',
        imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=300',
        count: '890',
      ),
      FeaturedThemeModel(
        id: '3',
        name: '黑白瞬间',
        imageUrl: 'https://images.unsplash.com/photo-1493397212122-2b85dda8106b?w=300',
        count: '3.1k',
      ),
      FeaturedThemeModel(
        id: '4',
        name: '光影几何',
        imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=300',
        count: '1.5k',
      ),
    ];
  }

  static List<CategoryModel> getCategories() {
    return const [
      CategoryModel(
        id: '1',
        tag: '极简',
        imageUrl: 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?w=200',
        description: '少即是多，用最简单的元素表达最纯粹的美',
      ),
      CategoryModel(
        id: '2',
        tag: '胶片',
        imageUrl: 'https://images.unsplash.com/photo-1502691876148-a84978f5d81b?w=200',
        description: '复古胶片质感，记录时光的温度',
      ),
      CategoryModel(
        id: '3',
        tag: '纪实',
        imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=200',
        description: '真实记录生活瞬间，讲述背后的故事',
      ),
      CategoryModel(
        id: '4',
        tag: '人像',
        imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
        description: '捕捉人物神态，展现内心世界',
      ),
      CategoryModel(
        id: '5',
        tag: '建筑',
        imageUrl: 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=200',
        description: '几何线条与光影的完美结合',
      ),
      CategoryModel(
        id: '6',
        tag: '自然',
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=200',
        description: '大自然的鬼斧神工，震撼人心',
      ),
      CategoryModel(
        id: '7',
        tag: '街拍',
        imageUrl: 'https://images.unsplash.com/photo-1475721027785-f74eccf3734a?w=200',
        description: '城市街头的即兴创作，捕捉瞬间',
      ),
      CategoryModel(
        id: '8',
        tag: '风光',
        imageUrl: 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=200',
        description: '壮丽山河，记录自然的辽阔',
      ),
      CategoryModel(
        id: '9',
        tag: '微距',
        imageUrl: 'https://images.unsplash.com/photo-1491841431259-70037918223e?w=200',
        description: '放大细节，发现微观世界的奇妙',
      ),
      CategoryModel(
        id: '10',
        tag: '夜景',
        imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=200',
        description: '夜色迷人，光影交织的都市夜晚',
      ),
      CategoryModel(
        id: '11',
        tag: '黑白',
        imageUrl: 'https://images.unsplash.com/photo-1493397212122-2b85dda8106b?w=200',
        description: '去除色彩，用光影讲述故事',
      ),
      CategoryModel(
        id: '12',
        tag: '静物',
        imageUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=200',
        description: '平凡物品的不凡构图',
      ),
    ];
  }

  static List<PostModel> getPostsByCategory(String categoryId) {
    // 根据分类ID返回不同的帖子组合
    switch (categoryId) {
      case '1': // 极简
        return [
          PostModel(
            id: 'c1-1',
            userId: '1',
            userName: '林风',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?w=800',
            caption: '极简主义的极致表达，留白赋予作品更多想象空间。',
            likes: 1240,
            inspirations: 89,
            timeAgo: '1小时前',
          ),
          PostModel(
            id: 'c1-2',
            userId: '3',
            userName: '荒野猎人',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
            caption: '用最少的元素，讲述最深刻的故事。',
            likes: 2100,
            inspirations: 156,
            timeAgo: '3小时前',
          ),
          PostModel(
            id: 'c1-3',
            userId: '4',
            userName: '城市游侠',
            userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
            caption: '简洁不等于简单，是经过深思熟虑的设计。',
            likes: 678,
            inspirations: 34,
            timeAgo: '5小时前',
          ),
        ];
      case '2': // 胶片
        return [
          PostModel(
            id: 'c2-1',
            userId: '2',
            userName: '苏影',
            userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
            caption: '胶片的颗粒感，是数码无法复制的温度。',
            likes: 856,
            inspirations: 45,
            timeAgo: '2小时前',
          ),
          PostModel(
            id: 'c2-2',
            userId: '1',
            userName: '林风',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800',
            caption: '按下快门的那一刻，期待胶片带来的惊喜。',
            likes: 1240,
            inspirations: 89,
            timeAgo: '4小时前',
          ),
        ];
      case '3': // 纪实
        return [
          PostModel(
            id: 'c3-1',
            userId: '4',
            userName: '城市游侠',
            userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
            caption: '街头的故事，每个人都是主角。',
            likes: 678,
            inspirations: 34,
            timeAgo: '3小时前',
          ),
          PostModel(
            id: 'c3-2',
            userId: '3',
            userName: '荒野猎人',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
            caption: '真实记录生活，不加修饰的瞬间最动人。',
            likes: 2100,
            inspirations: 156,
            timeAgo: '6小时前',
          ),
        ];
      case '4': // 人像
        return [
          PostModel(
            id: 'c4-1',
            userId: '1',
            userName: '林风',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800',
            caption: '眼神里藏着整个世界。',
            likes: 1240,
            inspirations: 89,
            timeAgo: '1小时前',
          ),
          PostModel(
            id: 'c4-2',
            userId: '2',
            userName: '苏影',
            userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
            caption: '捕捉人物最自然的状态。',
            likes: 856,
            inspirations: 45,
            timeAgo: '3小时前',
          ),
        ];
      case '5': // 建筑
        return [
          PostModel(
            id: 'c5-1',
            userId: '3',
            userName: '荒野猎人',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800',
            caption: '几何线条与光影的完美结合。',
            likes: 2100,
            inspirations: 156,
            timeAgo: '2小时前',
          ),
          PostModel(
            id: 'c5-2',
            userId: '4',
            userName: '城市游侠',
            userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800',
            caption: '现代建筑的线条美感。',
            likes: 678,
            inspirations: 34,
            timeAgo: '5小时前',
          ),
        ];
      case '6': // 自然
        return [
          PostModel(
            id: 'c6-1',
            userId: '3',
            userName: '荒野猎人',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
            caption: '大自然才是最伟大的摄影师。',
            likes: 2100,
            inspirations: 156,
            timeAgo: '1天前',
          ),
          PostModel(
            id: 'c6-2',
            userId: '1',
            userName: '林风',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800',
            caption: '清晨的阿尔卑斯山，第一缕阳光穿透云雾。',
            likes: 1240,
            inspirations: 89,
            timeAgo: '2小时前',
          ),
        ];
      case '7': // 街拍
        return [
          PostModel(
            id: 'c7-1',
            userId: '2',
            userName: '苏影',
            userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
            caption: '赛博朋克风格的街头摄影，霓虹与雨水的交织。',
            likes: 856,
            inspirations: 45,
            timeAgo: '5小时前',
          ),
          PostModel(
            id: 'c7-2',
            userId: '4',
            userName: '城市游侠',
            userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
            caption: '街头的故事，每个人都是主角。',
            likes: 678,
            inspirations: 34,
            timeAgo: '3小时前',
          ),
        ];
      case '8': // 风光
        return [
          PostModel(
            id: 'c8-1',
            userId: '3',
            userName: '荒野猎人',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
            caption: '无人之境的静谧，大自然的低语。',
            likes: 2100,
            inspirations: 156,
            timeAgo: '1天前',
          ),
          PostModel(
            id: 'c8-2',
            userId: '1',
            userName: '林风',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800',
            caption: '清晨的阿尔卑斯山，第一缕阳光穿透云雾。',
            likes: 1240,
            inspirations: 89,
            timeAgo: '2小时前',
          ),
        ];
      case '9': // 微距
        return [
          PostModel(
            id: 'c9-1',
            userId: '2',
            userName: '苏影',
            userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
            caption: '放大细节，发现微观世界的奇妙。',
            likes: 856,
            inspirations: 45,
            timeAgo: '4小时前',
          ),
        ];
      case '10': // 夜景
        return [
          PostModel(
            id: 'c10-1',
            userId: '2',
            userName: '苏影',
            userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
            caption: '赛博朋克风格的街头摄影，霓虹与雨水的交织。',
            likes: 856,
            inspirations: 45,
            timeAgo: '5小时前',
          ),
          PostModel(
            id: 'c10-2',
            userId: '4',
            userName: '城市游侠',
            userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
            caption: '街头的故事，每个人都是主角。',
            likes: 678,
            inspirations: 34,
            timeAgo: '3小时前',
          ),
        ];
      case '11': // 黑白
        return [
          PostModel(
            id: 'c11-1',
            userId: '3',
            userName: '荒野猎人',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1493397212122-2b85dda8106b?w=800',
            caption: '去除色彩，用光影讲述故事。',
            likes: 2100,
            inspirations: 156,
            timeAgo: '1天前',
          ),
          PostModel(
            id: 'c11-2',
            userId: '1',
            userName: '林风',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?w=800',
            caption: '清晨的阿尔卑斯山，第一缕阳光穿透云雾。',
            likes: 1240,
            inspirations: 89,
            timeAgo: '2小时前',
          ),
        ];
      case '12': // 静物
        return [
          PostModel(
            id: 'c12-1',
            userId: '2',
            userName: '苏影',
            userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
            imageUrl: 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800',
            caption: '平凡物品的不凡构图。',
            likes: 856,
            inspirations: 45,
            timeAgo: '5小时前',
          ),
        ];
      default:
        return getMockPosts();
    }
  }

  static UserModel getCurrentUser() {
    return const UserModel(
      id: 'current_user',
      userName: '屿光',
      displayName: '屿光 (Islet Light)',
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300',
      bio: '以光为笔，以影为墨。捕捉平凡生活中的不凡瞬间。\n| 徕卡玩家 | 纪实摄影师',
      postsCount: 42,
      followersCount: 1500,
      inspirationsCount: 892,
    );
  }

  static List<String> getUserGalleryImages() {
    return List.generate(
      12,
      (i) => 'https://images.unsplash.com/photo-${1530000000000 + i * 8000}?w=300',
    );
  }

  static List<PostModel> getAllAvailablePosts() {
    final map = <String, PostModel>{};
    for (final post in getMockPosts()) {
      map[post.id] = post;
    }
    for (final category in getCategories()) {
      for (final post in getPostsByCategory(category.id)) {
        map[post.id] = post;
      }
    }
    return map.values.toList();
  }

  static PostModel? findPostById(String id, {List<PostModel> extra = const []}) {
    for (final post in [...extra, ...getAllAvailablePosts()]) {
      if (post.id == id) return post;
    }
    return null;
  }

  static List<PostModel> getPostsByTopic(String topicId) {
    final all = getAllAvailablePosts();
    if (all.isEmpty) return [];
    final index = ((int.tryParse(topicId) ?? 1) - 1).clamp(0, all.length - 1);
    final result = <PostModel>[];
    for (var i = 0; i < 3 && i < all.length; i++) {
      result.add(all[(index + i) % all.length]);
    }
    return result;
  }

  static List<PostModel> getPostsByTheme(String themeId) {
    final all = getAllAvailablePosts();
    if (all.isEmpty) return [];
    final index = ((int.tryParse(themeId) ?? 1) - 1).clamp(0, all.length - 1);
    final result = <PostModel>[];
    for (var i = 0; i < 4 && i < all.length; i++) {
      result.add(all[(index + i) % all.length]);
    }
    return result;
  }

  static List<PostModel> searchPosts(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];

    final posts = getAllAvailablePosts();
    final topics = getTrendingTopics();
    final categories = getCategories();
    final themes = getFeaturedThemes();

    final matchedTopicNames = topics
        .where((t) => t.name.toLowerCase().contains(q))
        .map((t) => t.name.toLowerCase())
        .toSet();
    final matchedCategoryTags = categories
        .where((c) => c.tag.toLowerCase().contains(q) || c.description.toLowerCase().contains(q))
        .map((c) => c.tag.toLowerCase())
        .toSet();
    final matchedThemeNames = themes
        .where((t) => t.name.toLowerCase().contains(q))
        .map((t) => t.name.toLowerCase())
        .toSet();

    return posts.where((post) {
      final caption = post.caption.toLowerCase();
      final userName = post.userName.toLowerCase();
      if (caption.contains(q) || userName.contains(q)) return true;
      for (final tag in matchedCategoryTags) {
        if (caption.contains(tag)) return true;
      }
      for (final name in matchedThemeNames) {
        if (caption.contains(name)) return true;
      }
      for (final name in matchedTopicNames) {
        if (caption.contains(name.replaceAll('# ', '').replaceAll('#', ''))) return true;
      }
      return false;
    }).toList();
  }
}
