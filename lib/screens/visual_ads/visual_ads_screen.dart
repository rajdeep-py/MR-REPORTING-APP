import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mr_asm_app/routes/app_router.dart';
import '../../notifiers/visual_ads_notifier.dart';
import '../../theme/app_theme.dart';

class VisualAdsScreen extends ConsumerStatefulWidget {
  const VisualAdsScreen({super.key});

  @override
  ConsumerState<VisualAdsScreen> createState() => _VisualAdsScreenState();
}

class _VisualAdsScreenState extends ConsumerState<VisualAdsScreen> {
  final PageController _pageController = PageController();
  bool _isSearchVisible = false;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Force Landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Full screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Revert to portrait/default
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adsState = ref.watch(visualAdsNotifierProvider);
    final notifier = ref.read(visualAdsNotifierProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.home);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Visual Ads Viewer
            if (adsState.filteredAds.isEmpty)
              const Center(
                child: Text(
                  'No Visual Ads Found',
                  style: TextStyle(color: Colors.white),
                ),
              )
            else
              PageView.builder(
                controller: _pageController,
                itemCount: adsState.filteredAds.length,
                itemBuilder: (context, index) {
                  final ad = adsState.filteredAds[index];
                  return InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Center(
                      child: Image.network(
                        ad.imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Iconsax.image,
                              color: Colors.white,
                              size: 50,
                            ),
                      ),
                    ),
                  );
                },
              ),

            // Top Control Bar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  // Back Button
                  _circleButton(Iconsax.arrow_left, () => context.pop()),
                  const Spacer(),
                  // Product Name (Current Ad)
                  if (!_isSearchVisible && adsState.filteredAds.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        adsState
                            .filteredAds[0]
                            .productName, // Simplified: should track current index
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const Spacer(),
                  // Search Button
                  _circleButton(
                    _isSearchVisible
                        ? Iconsax.close_circle
                        : Iconsax.search_normal,
                    () {
                      setState(() {
                        _isSearchVisible = !_isSearchVisible;
                        if (!_isSearchVisible) {
                          _searchCtrl.clear();
                          notifier.setSearchQuery('');
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            // Search Bar Overlay
            if (_isSearchVisible)
              Positioned(
                top: 80,
                left: 50,
                right: 50,
                child: FadeInDown(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(50),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchCtrl,
                      autofocus: true,
                      onChanged: notifier.setSearchQuery,
                      decoration: const InputDecoration(
                        hintText: 'Search product name...',
                        border: InputBorder.none,
                        icon: Icon(
                          Iconsax.search_normal,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Swipe Indicator
            if (adsState.filteredAds.length > 1)
              const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.arrow_left_1,
                        color: Colors.white54,
                        size: 16,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'SWIPE FOR NEXT',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Iconsax.arrow_right_1,
                        color: Colors.white54,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(150),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
