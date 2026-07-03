# 光影志 (LensMate) - 项目结构说明

## 📁 项目结构

```
lib/
├── main.dart                          # 应用入口
├── models/                            # 数据模型
│   ├── post_model.dart               # 帖子和评论模型
│   ├── exhibition_model.dart         # 影展和挑战模型
│   ├── explore_model.dart            # 话题、主题、分类模型
│   └── user_model.dart               # 用户模型
├── screens/                           # 页面
│   ├── main_shell.dart               # 主框架（底部导航）
│   ├── home_screen.dart              # 灵感流页面
│   ├── explore_screen.dart           # 发现页面
│   ├── exhibition_screen.dart        # 影展页面
│   ├── profile_screen.dart           # 个人资料页面
│   ├── edit_profile_screen.dart      # 编辑资料页面
│   ├── post_detail_screen.dart       # 帖子详情页面
│   └── create_post_screen.dart       # 创建帖子页面
├── widgets/                           # 可复用组件
│   └── post_card.dart                # 帖子卡片组件
├── services/                          # 服务层
│   ├── mock_data_service.dart        # 模拟数据服务
│   └── storage_service.dart          # 本地存储服务
└── theme/                             # 主题配置
    └── app_theme.dart                # 应用主题和颜色定义
```

## 🎨 核心功能

### 1. 灵感流 (HomeScreen)
- 展示摄影作品流
- 点赞和灵感勋章功能
- 点击查看详情
- 使用 shared_preferences 持久化点赞状态

### 2. 发现 (ExploreScreen)
- 热门话题标签
- 精选摄影专题网格
- 分类探索（极简、胶片、纪实等）
- 搜索功能

### 3. 影展 (ExhibitionScreen)
- 线上影展列表
- 本周摄影挑战
- 参与挑战功能

### 4. 个人资料 (ProfileScreen)
- 用户信息展示
- 作品网格/收藏切换
- 编辑资料功能
- 统计数据（作品数、关注数、共勉数）

### 5. 创建帖子 (CreatePostScreen)
- 照片选择（占位符）
- 内心自述输入
- 发布功能

## 🔧 技术栈

- **状态管理**: setState（简单状态管理）
- **本地存储**: shared_preferences
- **网络图片**: Image.network
- **导航**: Navigator + MaterialPageRoute
- **UI**: Material Design 3

## 📦 依赖包

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2  # 本地存储
  intl: ^0.19.0                # 国际化支持
```

## 🎯 设计特点

1. **极简主义**: 黑白灰配色，突出摄影作品
2. **沉浸式体验**: 4:5 比例大图展示
3. **iOS 风格**: 毛玻璃效果、圆角设计
4. **流畅动画**: 页面切换、按钮交互动画
5. **响应式设计**: 适配不同屏幕尺寸

## 🚀 运行项目

```bash
# 安装依赖
flutter pub get

# 运行应用
flutter run

# 分析代码
flutter analyze

# 构建 iOS
flutter build ios

# 构建 Android
flutter build apk
```

## 📝 注意事项

1. 所有图片使用 Unsplash 网络图片
2. 不使用 freezed 包和 part 语法
3. 不使用 cached_network_image
4. 不需要本地图片资源
5. 不需要账户功能
6. 不需要外部字体
7. 不使用 share_plus

## 🎨 颜色系统

- **主色**: 黑色 (#000000)
- **背景**: 白色 (#FFFFFF)
- **灰度**: gray50 ~ gray900
- **强调色**: 
  - 橙色 (热门)
  - 蓝色 (趋势)
  - 黄色 (灵感勋章)
  - 红色 (点赞)

## 📱 页面路由

```
MainShell (底部导航)
├── HomeScreen (灵感流)
│   └── PostDetailScreen (帖子详情)
├── ExploreScreen (发现)
├── ExhibitionScreen (影展)
└── ProfileScreen (个人资料)
    └── EditProfileScreen (编辑资料)

CreatePostScreen (模态弹窗)
```

## 🔄 数据流

```
MockDataService (模拟数据)
    ↓
Screens (页面状态)
    ↓
Widgets (UI 组件)
    ↓
StorageService (持久化)
```

## ✅ 完成状态

- ✅ 所有页面已实现
- ✅ 所有功能已实现
- ✅ 零编译错误
- ✅ 零分析警告
- ✅ 代码规范符合 Flutter 最佳实践
