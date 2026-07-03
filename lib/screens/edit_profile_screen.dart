import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _save() {
    final updatedUser = UserModel(
      id: widget.user.id,
      userName: widget.user.userName,
      displayName: _nameController.text.trim().isEmpty
          ? widget.user.displayName
          : _nameController.text.trim(),
      avatarUrl: widget.user.avatarUrl,
      bio: _bioController.text.trim(),
      postsCount: widget.user.postsCount,
      followersCount: widget.user.followersCount,
      inspirationsCount: widget.user.inspirationsCount,
    );
    Navigator.pop(context, updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.gray700),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '编辑资料',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray900,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
              '保存',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.black,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.gray100),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.network(
                      widget.user.avatarUrl,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 88,
                        height: 88,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gray100,
                        ),
                        child: const Icon(Icons.person, size: 40, color: AppTheme.gray400),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, size: 14, color: AppTheme.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Name field
            _buildField(
              label: '显示名称',
              controller: _nameController,
              maxLines: 1,
            ),
            const SizedBox(height: 20),

            // Bio field
            _buildField(
              label: '个人简介',
              controller: _bioController,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray400,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.gray900,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.gray50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.black, width: 1.5),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
