import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/cards/content_card.dart';

class ContactCardWide extends StatelessWidget {
  const ContactCardWide({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentCard(
      padding: comfortableCardInset,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "Reach us",
                  overflow: TextOverflow.ellipsis,
                  style: heading(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Tooltip(
                  message: "WhatsApp",
                  child: IconButton.filled(
                    color: theme.colorScheme.onPrimary,
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(Uri.encodeFull(
                          "https://whatsapp.com")))) {
                        throw Exception("Could not launch Whatsapp URL");
                      }
                    },
                    icon: const Icon(FontAwesomeIcons.whatsapp),
                  ),
                ),
              ),
              Tooltip(
                message: "Email",
                child: IconButton.filled(
                  color: theme.colorScheme.onPrimary,
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(
                        Uri.encodeFull("mailto:test@example.com")))) {
                      throw Exception("Could not launch email URL");
                    }
                  },
                  icon: const Icon(Icons.email_outlined),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
