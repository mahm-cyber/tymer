import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_payment/online_payment.dart';
import 'package:online_payment/src/online_payment_cubit.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Entry widget — StatelessWidget as per project convention.
/// Wires up [BlocProvider] and passes the URL down to [OnlinePaymentView].
class OnlinePaymentScreen extends StatelessWidget {
  const OnlinePaymentScreen({
    super.key,
    required this.url,
    required this.transactionId,
    required this.walletRepository,
    required this.onPaymentSuccess,
    required this.onPaymentFailure,
  });

  final String url;
  final String transactionId;
  final WalletRepository walletRepository;
  final VoidCallback onPaymentSuccess;
  final VoidCallback onPaymentFailure;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnlinePaymentCubit>(
      create: (_) => OnlinePaymentCubit(
        onPaymentSuccess: onPaymentSuccess,
        onPaymentFailure: onPaymentFailure,
      ),
      child: OnlinePaymentView(url: url),
    );
  }

}


/// [StatefulWidget] — only exception to the StatelessWidget-View rule.
/// Required because [WebViewController] must be initialised in [initState].
class OnlinePaymentView extends StatefulWidget {
  const OnlinePaymentView({super.key, required this.url});

  final String url;

  @override
  State<OnlinePaymentView> createState() => _OnlinePaymentViewState();
}

class _OnlinePaymentViewState extends State<OnlinePaymentView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<OnlinePaymentCubit>();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Intercept the Paymob post_pay redirect — this URL contains
            // the payment result as query parameters (success=true/false).
            // We parse the result and prevent the navigation.
            // if (request.url.contains('post_pay')) {
            //   cubit.onPaymentResultUrl(request.url);
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
         
          onPageStarted: (url) {
            if (url.contains('post_pay')) {
              cubit.onPaymentResultUrl(url);
            } else {
              cubit.onPageStarted();
            }
          },                        
          onPageFinished: (url) {                                                                                                                       
            if (url.contains('post_pay')) {
              cubit.onPaymentResultUrl(url);
            } else {
              cubit.onPageFinished();
            }
          },
        ),
      )                   
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlinePaymentCubit, OnlinePaymentState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == OnlinePaymentStatus.failure) {
          final l10n = OnlinePaymentLocalizations.of(context);
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: state.errorMessage ?? l10n.paymentFailed,
            ),
          );
        }
        if (state.status == OnlinePaymentStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: state.successMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final l10n = OnlinePaymentLocalizations.of(context);
        final isLoading = state.status == OnlinePaymentStatus.loading;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appBarTitle),
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (isLoading) const CenteredCircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
