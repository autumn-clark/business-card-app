import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/pages/card_form_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BusinessCard extends StatelessWidget {
  final BusinessCardModel cardData;
  final VoidCallback onCardUpdated;

  const BusinessCard({
    Key? key,
    required this.cardData,
    required this.onCardUpdated,
  }) : super(key: key);

  void _showQrModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87, // Darker overlay for better contrast
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Scan to Connect',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  QrImageView(
                    data: cardData.uid ?? 'no-id',
                    version: QrVersions.auto,
                    size: 200,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    cardData.firstName ?? 'Unknown',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    cardData.company ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: screenWidth - 50,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar/Logo Container
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 80,
                          width: 80,
                          child: //cardData.avatarUrl != null
                              //? Image.network(cardData.avatarUrl!):
                               Icon(
                            Icons.person,
                            size: 40,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        // Main Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cardData.firstName ?? ''} ${cardData.lastName ?? ''}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (cardData.occupation != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    cardData.occupation!,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              if (cardData.company != null)
                                Text(
                                  cardData.company!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Contact Information
                    if (cardData.email != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.email, size: 16),
                            const SizedBox(width: 8),
                            Text(cardData.email!),
                          ],
                        ),
                      ),
                    if (cardData.tels != null && cardData.tels!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.phone, size: 16),
                            const SizedBox(width: 8),
                            Text(cardData.tels!.join(', ')),
                          ],
                        ),
                      ),
                    // Social Links (if available)
                    // if (cardData.links != null)
                      // Wrap(
                      //   spacing: 8,
                      //   children: cardData.links!
                      //       .map((social) => Chip(
                      //     label: Text(social.platform),
                      //   ))
                      //       .toList(),
                      // ),
                  ],
                ),
              ),
              // Decorative Cloud
              Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.3,
                  child: SvgPicture.asset(
                    'assets/cloud.svg',
                    width: 150,
                    height: 225,
                  ),
                ),
              ),
              // Action Buttons
              Positioned(
                bottom: 8,
                right: 8,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => _showQrModal(context),
                      icon: const Icon(Icons.qr_code),
                      tooltip: 'Show QR Code',
                    ),
                    IconButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardFormPage(cardData: cardData),
                          ),
                        );
                        onCardUpdated();
                      },
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit Card',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyCard extends StatelessWidget {
  final VoidCallback onCardAdded;

  const EmptyCard({super.key, required this.onCardAdded});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardFormPage()),
          );
          onCardAdded();
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[500]!,
                Colors.grey[400]!,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.add, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Add New Business Card',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}