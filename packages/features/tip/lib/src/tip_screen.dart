import 'package:btc_pay_repository/btc_pay_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:tip/src/tip_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:lnurl_pay_repository/lnurl_pay_repository.dart';

typedef BTCPayInvoiceCreated = Function(
    String label, String url, BuildContext context);

typedef LNURLPayInvoiceCreated = Function(String invoice,
    LNURLPayRepository lnurlPayRepository, BuildContext context);

class TipScreen extends StatelessWidget {
  const TipScreen({
    super.key,
    // required this.onInvoiceCreateSuccess,
    required this.onBTCPayInvoiceCreatedSuccess,
    required this.onLNURLPayInvoiceCreatedSuccess,
    required this.btcPayRepository,
    required this.lnurlPayRepository,
    required this.userRepository,
    required this.unitPreference,
  });

  // final InvoiceCreated onInvoiceCreateSuccess;
  final BTCPayInvoiceCreated onBTCPayInvoiceCreatedSuccess;
  final LNURLPayInvoiceCreated onLNURLPayInvoiceCreatedSuccess;
  final BTCPayRepository btcPayRepository;
  final LNURLPayRepository lnurlPayRepository;
  final UserRepository userRepository;
  final String unitPreference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TipCubit>(
      create: (_) => TipCubit(
        btcPayRepository: btcPayRepository,
        lnurlPayRepository: lnurlPayRepository,
        userRepository: userRepository,
      ),
      child: TipScreenView(
        // onInvoiceCreateSuccess: onInvoiceCreateSuccess,
        onBTCPayInvoiceCreatedSuccess: onBTCPayInvoiceCreatedSuccess,
        onLNURLPayInvoiceCreatedSuccess: onLNURLPayInvoiceCreatedSuccess,
        userRepository: userRepository,
        isBtcUnit: unitPreference == 'tip-btc' ? true : false,
        lnurlPayRepository: lnurlPayRepository,
      ),
    );
  }
}

class TipScreenView extends StatelessWidget {
  const TipScreenView({
    super.key,
    required this.onBTCPayInvoiceCreatedSuccess,
    required this.onLNURLPayInvoiceCreatedSuccess,
    required this.userRepository,
    required this.isBtcUnit,
    required this.lnurlPayRepository,
  });
  // final InvoiceCreated onInvoiceCreateSuccess;
  final BTCPayInvoiceCreated onBTCPayInvoiceCreatedSuccess;
  final LNURLPayInvoiceCreated onLNURLPayInvoiceCreatedSuccess;
  final UserRepository userRepository;
  final bool isBtcUnit;
  final LNURLPayRepository lnurlPayRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  children: [
                    Container(
                      color: black.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(
                        vertical: Spacing.medium,
                      ),
                      child: Center(
                        child: Text(
                          'Tip ${userRepository.getUsername}',
                          style: const TextStyle(
                            fontSize: FontSize.large,
                            fontWeight: FontWeight.w500,
                            color: shark,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: _TipForm(
                        // onInvoiceCreateSuccess: onInvoiceCreateSuccess,
                        onBTCPayInvoiceCreatedSuccess:
                            onBTCPayInvoiceCreatedSuccess,
                        onLNURLPayInvoiceCreatedSuccess:
                            onLNURLPayInvoiceCreatedSuccess,
                        userRepository: userRepository,
                        isBtcUnit: isBtcUnit,
                        lnurlPayRepository: lnurlPayRepository,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TipForm extends StatefulWidget {
  const _TipForm({
    // required this.onInvoiceCreateSuccess,
    required this.userRepository,
    required this.isBtcUnit,
    required this.onBTCPayInvoiceCreatedSuccess,
    required this.onLNURLPayInvoiceCreatedSuccess,
    required this.lnurlPayRepository,
  });
  // final InvoiceCreated onInvoiceCreateSuccess;
  final UserRepository userRepository;
  final bool isBtcUnit;
  final BTCPayInvoiceCreated onBTCPayInvoiceCreatedSuccess;
  final LNURLPayInvoiceCreated onLNURLPayInvoiceCreatedSuccess;
  final LNURLPayRepository lnurlPayRepository;

  @override
  State<_TipForm> createState() => _TipFormState();
}

class _TipFormState extends State<_TipForm> {
  final _nameFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<TipCubit>();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        cubit.onNameUnfocused();
      }
    });

    _messageFocusNode.addListener(() {
      if (!_messageFocusNode.hasFocus) {
        cubit.onMessageUnfocused();
      }
    });

    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) {
        cubit.onAmountBTCUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _messageFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TipCubit, TipState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success &&
            state.invoice != null) {
          if (widget.isBtcUnit) {
            widget.onBTCPayInvoiceCreatedSuccess(
                'Tip Me', state.invoice?.checkoutLink ?? '', context);
          } else {
            widget.onLNURLPayInvoiceCreatedSuccess(
                state.invoice?.checkoutLink ?? '',
                widget.lnurlPayRepository,
                context);
          }

          return;
        }

        final hasSubmissionError =
            state.submissionStatus == SubmissionStatus.apiError ||
                state.submissionStatus == SubmissionStatus.genericError;

        if (hasSubmissionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              state.submissionStatus == SubmissionStatus.apiError
                  ? const SnackBar(
                      content: Text(
                        'unauthorized api request exception!',
                      ),
                    )
                  : const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        final nameError = state.name.isNotValid ? state.name.error : null;
        final messageError =
            state.message.isNotValid ? state.message.error : null;
        final amountBTCError =
            state.amountBTC.isNotValid ? state.amountBTC.error : null;
        final amountSATError =
            state.amountSAT.isNotValid ? state.amountSAT.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;

        final cubit = context.read<TipCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // START: Name Field
            const Text(
              'Name',
              style: TextStyle(
                fontSize: FontSize.medium,
              ),
            ),
            const SizedBox(height: Spacing.small),
            TipTextField(
              hintText: "Satoshi Nakamoto",
              focusNode: _nameFocusNode,
              onChanged: cubit.onNameChanged,
              textInputAction: TextInputAction.next,
              autoCorrect: false,
              enabled: !isSubmissionInProgress,
              errorText: nameError == null
                  ? null
                  : (nameError == NameValidationError.empty
                      ? 'Your name can\'t be empty.'
                      : 'This name is not valid.'),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_messageFocusNode);
              },
            ),
            const SizedBox(height: Spacing.xSmall),
            Text(
              'Let ${widget.userRepository.getUsername} know who is donating. Or leave blank to remain anonymous.',
              style: const TextStyle(
                fontSize: FontSize.small,
              ),
            ),
            // END: Name Field
            const SizedBox(
              height: Spacing.large,
            ),
            // START: Message Field
            const Text(
              'Message',
              style: TextStyle(
                fontSize: FontSize.medium,
              ),
            ),
            const SizedBox(height: Spacing.small),
            TipTextField(
              hintText: "Message from Satoshi",
              focusNode: _messageFocusNode,
              onChanged: cubit.onMessageChanged,
              textInputAction: TextInputAction.next,
              autoCorrect: false,
              enabled: !isSubmissionInProgress,
              errorText: messageError == null
                  ? null
                  : (messageError == MessageValidationError.empty
                      ? 'Your message can\'t be empty.'
                      : 'This message is not valid.'),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_amountFocusNode);
              },
            ),
            const SizedBox(height: Spacing.xSmall),
            Text(
              'Send a message to ${widget.userRepository.getUsername}. Or don\'t.',
              style: const TextStyle(
                fontSize: FontSize.small,
              ),
            ),
            // END: Message Field
            const SizedBox(
              height: Spacing.large,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amount to Tip',
                        style: TextStyle(
                          fontSize: FontSize.medium,
                        ),
                      ),
                      const SizedBox(height: Spacing.small),
                      widget.isBtcUnit
                          ? TipTextField(
                              hintText: '0.00001',
                              focusNode: _amountFocusNode,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => cubit.onAmountBTCChanged(
                                  double.tryParse(value) ?? 0.0),
                              textInputAction: TextInputAction.done,
                              autoCorrect: false,
                              enabled: !isSubmissionInProgress,
                              errorText: amountBTCError == null
                                  ? null
                                  : (amountBTCError ==
                                          AmountBTCValidationError.dust
                                      ? 'Please use Lightning for smaller tips. Thank you.'
                                      : 'This amount is not valid.'),
                              onEditingComplete: () =>
                                  cubit.onSubmit(widget.isBtcUnit),
                            )
                          : TipTextField(
                              hintText: '1',
                              focusNode: _amountFocusNode,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => cubit
                                  .onAmountSATChanged(int.tryParse(value) ?? 1),
                              textInputAction: TextInputAction.done,
                              autoCorrect: false,
                              enabled: !isSubmissionInProgress,
                              errorText: amountSATError == null
                                  ? null
                                  : (amountSATError ==
                                          AmountSATValidationError.onchain
                                      ? 'Please use On-Chain for bigger tips. Thank you.'
                                      : 'This amount is not valid.'),
                              onEditingComplete: () =>
                                  cubit.onSubmit(widget.isBtcUnit),
                            ),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.mediumLarge),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: FontSize.medium,
                        ),
                      ),
                      const SizedBox(height: Spacing.small),
                      TipTextField(
                        hintText: widget.isBtcUnit ? 'BTC' : 'SAT',
                        enabled: false,
                        controller: TextEditingController(
                            text: widget.isBtcUnit ? 'BTC' : 'SAT'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // END: Amount and Currency Field Row
            const SizedBox(
              height: Spacing.large,
            ),
            isSubmissionInProgress
                ? ExpandedElevatedButton.inProgress(
                    label: 'Tip',
                  )
                : ExpandedElevatedButton(
                    label: 'Tip',
                    onTap: () => cubit.onSubmit(widget.isBtcUnit),
                    icon: Icon(
                      widget.isBtcUnit
                          ? CupertinoIcons.bitcoin
                          : Icons.bolt_sharp,
                    ),
                    color: widget.isBtcUnit ? persianBlue : orange,
                  ),
          ],
        );
      },
    );
  }
}
