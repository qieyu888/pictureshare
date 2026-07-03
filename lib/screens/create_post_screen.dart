import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isPosting = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _post() async {
    if (_captionController.text.trim().isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请添加照片或填写内容'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    setState(() => _isPosting = true);
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (mounted) {
      Navigator.pop(context, {
        'image': _selectedImage,
        'caption': _captionController.text.trim(),
      });
    }
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
          '新作品',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray900,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isPosting ? null : _post,
            child: _isPosting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.black,
                    ),
                  )
                : const Text(
                    '发布',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image picker
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: AppTheme.gray50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.gray100,
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: _selectedImage != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: _removeImage,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.gray100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 32,
                              color: AppTheme.gray400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '点击选择照片',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.gray500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '从相册中选择你的作品',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray400,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Caption
            const Text(
              '内心自述',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.gray400,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _captionController,
              maxLines: 5,
              maxLength: 300,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.gray900,
                height: 1.6,
              ),
              decoration: InputDecoration(
                hintText: '分享这张照片背后的故事与感悟...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.gray400,
                ),
                filled: true,
                fillColor: AppTheme.gray50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppTheme.black, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(16),
                counterStyle: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.gray400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
