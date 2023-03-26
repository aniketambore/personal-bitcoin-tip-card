import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lnurl_pay_repository/lnurl_pay_repository.dart';

class LNURLInvoiceScreen extends StatelessWidget {
  const LNURLInvoiceScreen({
    super.key,
    required this.bolt11Invoice,
    required this.lnurlPayRepository,
  });

  final String bolt11Invoice;
  final LNURLPayRepository lnurlPayRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bolt11Invoice),
      ),
      body: Container(
        padding: const EdgeInsets.all(Spacing.mediumLarge),
        child: Center(
          child: ResponsiveBuilder(
            maxWidth: 768,
            maxHeight: 503,
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              'Tip Sats',
                              style: TextStyle(
                                fontSize: FontSize.mediumLarge,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ExpandedElevatedButton(
                              label: 'WebLN',
                              color: treePoppy,
                              onTap: () =>
                                  lnurlPayRepository.sendPayment(bolt11Invoice),
                              icon: const Icon(Icons.bolt_outlined),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: Spacing.mediumLarge),
                      QrCard(qrData: bolt11Invoice),
                      const SizedBox(height: Spacing.mediumLarge),
                      const Text(
                        'Scan the above invoice to tip in sats',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.medium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Spacing.xLarge),
                      ExpandedElevatedButton(
                        label: 'Copy Invoice',
                        icon: const Icon(Icons.copy),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: bolt11Invoice));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code copied to clipboard!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
