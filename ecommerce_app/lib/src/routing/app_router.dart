import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/products_list/products_list_screen.dart';

enum AppRoute {
  home,
  leaveReview,
  cart,
  orders,
  account,
  checkout,
  signIn,
  product,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OrdersListScreen(),
      routes: [
        GoRoute(
          path: 'Product/:id',
          name: AppRoute.product.name,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductScreen(productId: productId);
          },
          routes: [
            GoRoute(
              path: 'review',
              name: AppRoute.leaveReview.name,
              pageBuilder: (context, state) {
                var productId;
                return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: LeaveReviewScreen(productId: productId));
              },
            )
          ],
        ),
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
          routes: [
            GoRoute(
              path: 'checkout',
              name: AppRoute.leaveReview.name,
              pageBuilder: (context, state) {
                var productId;
                return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child:CheckoutScreen());
              },
            )
          ],
        ),
      ],
    )
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
