import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum LegalDocumentType { userAgreement, privacyPolicy }

class LegalDocumentScreen extends StatelessWidget {
  final LegalDocumentType type;

  const LegalDocumentScreen({super.key, required this.type});

  String get _title =>
      type == LegalDocumentType.userAgreement ? '用户协议' : '隐私政策';

  String get _content {
    if (type == LegalDocumentType.userAgreement) {
      return '''
欢迎使用光影志！

在使用本应用之前，请您仔细阅读并充分理解本《用户协议》的全部内容。

一、服务说明
光影志是一款面向摄影爱好者的图片分享与灵感交流应用。我们致力于为用户提供优质的摄影内容浏览、作品发布和影展体验。

二、用户行为规范
1. 您应保证所发布的内容不侵犯他人知识产权、肖像权等合法权益；
2. 不得发布违法、暴力、色情或其他违反公序良俗的内容；
3. 不得利用本应用从事任何危害网络安全或干扰正常运营的行为。

三、内容版权
您在本应用发布的原创内容，其著作权归您所有。您授权光影志在应用内展示、推广您的作品，以便其他用户浏览和交流。

四、账号管理
您可以通过设置页面管理个人信息和隐私偏好。如需退出使用，可在设置中退出当前会话。

五、免责声明
本应用中的部分内容来源于用户上传或第三方，我们不对其准确性、完整性作保证。因网络状况、设备故障等不可抗力导致的服务中断，我们将尽力恢复但不承担相应责任。

六、协议变更
我们可能会适时修订本协议。修订后的协议将在应用内公布，继续使用本应用即视为您接受修订后的协议。

七、联系我们
如有任何问题或建议，请通过应用内「设置 → 关于光影志 → 意见反馈」与我们联系。

最后更新日期：2026年7月3日
''';
    }
    return '''
光影志隐私政策

我们深知个人信息对您的重要性，并将尽全力保护您的隐私安全。请在使用光影志前，仔细阅读本隐私政策。

一、我们收集的信息
1. 设备信息：设备型号、操作系统版本，用于优化应用体验；
2. 使用数据：浏览记录、点赞与收藏偏好，用于个性化推荐；
3. 您主动提供的信息：昵称、头像、个人简介及发布的作品内容。

二、信息的使用
我们收集的信息将用于：
• 提供、维护和改进我们的服务；
• 个性化内容推荐；
• 保障账号与平台安全；
• 响应您的咨询与反馈。

三、信息的存储与保护
您的数据存储在本地设备及安全的服务环境中。我们采用行业标准的安全措施防止信息泄露、损毁或丢失。

四、信息的共享
我们不会向第三方出售您的个人信息。仅在以下情况下可能共享：
• 获得您的明确同意；
• 法律法规要求或政府机关依法提出请求；
• 为保护用户或公众的安全与合法权益。

五、您的权利
您有权：
• 访问、更正或删除您的个人信息；
• 在设置中管理隐私与通知偏好；
• 随时退出应用并清除本地会话数据。

六、未成年人保护
我们重视未成年人的个人信息保护。若您是未成年人，请在监护人指导下使用本应用。

七、政策更新
我们可能适时更新本隐私政策，更新后将在应用内通知您。

八、联系我们
如对本政策有任何疑问，请通过应用内「设置 → 关于光影志 → 意见反馈」联系我们。

最后更新日期：2026年7月3日
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          _title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray900,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.gray100),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Text(
          _content.trim(),
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.gray700,
            height: 1.8,
          ),
        ),
      ),
    );
  }
}
