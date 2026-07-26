import 'package:flutter/material.dart';

/// A Material Design 3 user profile card widget displaying user details,
/// social statistics, and quick interaction buttons.
class UserProfileCard extends StatelessWidget {
  /// The display name of the user.
  final String name;

  /// The email address of the user.
  final String email;

  /// Optional URL for the user's avatar image. Nullable.
  final String? avatarUrl;

  /// Total number of posts published by the user.
  final int postsCount;

  /// Total number of followers.
  final int followersCount;

  /// Total number of users followed.
  final int followingCount;

  /// Optional callback when Follow button is tapped.
  final VoidCallback? onFollowPressed;

  /// Optional callback when Message button is tapped.
  final VoidCallback? onMessagePressed;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    this.onFollowPressed,
    this.onMessagePressed,
  });

  /// Helper method to extract user initials for the avatar fallback.
  String _getInitials(String name) {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length.clamp(1, 2)).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  /// Helper method to format count numbers cleanly (e.g. 1.2k, 10M).
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Access Material 3 color scheme and text styles from Theme context
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      // Material 3 Card with subtle elevation and container styling
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        // Outer padding of 16px around the card contents
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // แก้ตรงนี้: CrossAlignment -> CrossAxisAlignment (ชื่อ class ที่ถูกต้อง)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section 1: User Avatar (Radius 32) with Initials Fallback
            CircleAvatar(
              radius: 32,
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty)
                  ? NetworkImage(avatarUrl!)
                  : null,
              // ป้องกัน error กรณีโหลดรูปไม่สำเร็จ (URL เสีย/ไม่มีเน็ต)
              onBackgroundImageError:
                  (avatarUrl != null && avatarUrl!.isNotEmpty)
                      ? (exception, stackTrace) {
                          debugPrint('Avatar failed to load: $exception');
                        }
                      : null,
              child: (avatarUrl == null || avatarUrl!.isEmpty)
                  ? Text(
                      _getInitials(name),
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 12),

            // Section 2: User Name & Email
            // Username using titleLarge TextStyle
            Text(
              name,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Email using bodyMedium TextStyle in onSurfaceVariant color
            Text(
              email,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Section 3: Action Buttons (Follow & Message side by side)
            Row(
              children: [
                // "Follow" FilledButton
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onFollowPressed ?? () {},
                    icon: const Icon(Icons.person_add_outlined, size: 18),
                    label: const Text('Follow'),
                  ),
                ),
                const SizedBox(width: 8), // 8px horizontal spacing

                // "Message" OutlinedButton
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onMessagePressed ?? () {},
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text('Message'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Section 4: Divider between actions and stats
            Divider(
              height: 1,
              thickness: 1,
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),

            // Section 5: Row of 3 Stats (Posts, Followers, Following)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatColumn(
                  label: 'Posts',
                  value: _formatCount(postsCount),
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                ),
                _StatColumn(
                  label: 'Followers',
                  value: _formatCount(followersCount),
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                ),
                _StatColumn(
                  label: 'Following',
                  value: _formatCount(followingCount),
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Private helper widget for each stat item (Number + Label)
class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _StatColumn({
    required this.label,
    required this.value,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Number / Count representation
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),

        // Label string in onSurfaceVariant color
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}