
import 'package:bumaba/Modules/Pembayaran/pulsa_page.dart';
import 'package:bumaba/Modules/PinSecure/pin_change_page.dart';
import 'package:bumaba/Modules/PinSecure/pin_setup_page.dart';
import 'package:bumaba/Modules/SHU/shu_page.dart';
import 'package:bumaba/Modules/Simpanan/simpanan_detail_page.dart';
import 'package:bumaba/Modules/Tagihan/tagihan_page.dart';
import 'package:bumaba/Modules/User/account_page.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'Modules/Notifikasi/notification_page.dart';
import 'Modules/Payment/payment_confirm.dart';
import 'Modules/Payment/payment_method.dart';
import 'Modules/Pembiayaan/pembiayaan_bayar.dart';
import 'Modules/Pembiayaan/pembiayaan_detail_page.dart';
import 'Modules/Pembiayaan/pembiayaan_tunai_detail_page.dart';
import 'Modules/Pembiayaan/pembiayaan_tunai_page.dart';
import 'Modules/PinSecure/pin_access_page.dart';
import 'Modules/PinSecure/pin_change_confirm_page.dart';
import 'Modules/PinSecure/pin_change_setup_page.dart';
import 'Modules/PinSecure/pin_confirm_page.dart';
import 'Modules/Services/services_page.dart';
import 'Modules/Simla/simla_pin.dart';
import 'Modules/Simla/transfer_confirm_page.dart';
import 'Modules/Simla/transfer_info.dart';
import 'Modules/Simpanan/simpanan_riwayat_page.dart';
import 'Modules/Simpanan/simpanan_tagihan.dart';
import 'Modules/Transaksi/transaksi_detail_page.dart';
import 'Modules/Transaksi/transaksi_page.dart';
import 'route_argument.dart';

import 'Modules/Splash/splash_page.dart';
import 'Modules/Simla/top_up_page.dart';
import 'Modules/Simla/transfer_page.dart';
import 'Modules/Simla/riwayat_page.dart';
import 'Modules/Simla/scan_page.dart';


import 'Modules/User/login_page.dart';

import 'Modules/Simpanan/simpanan_page.dart';
import 'Modules/Pembiayaan/pembiayaan_page.dart';
import 'Core/pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      // case '/Debug':
      //   return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case '/Starter':
      //   return MaterialPageRoute(builder: (_) => StarterPages());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      
      case '/PinSetup':
        return MaterialPageRoute(builder: (_) => PinSetupPage());
      case '/PinConfirm':
        return MaterialPageRoute(builder: (_) => PinConfirm(routeArgument: args as RouteArgument));
      case '/PinAccess':
        return MaterialPageRoute(builder: (_) => PinAccessPage());

        
      case '/PinChange':
        return MaterialPageRoute(builder: (_) => PinChangePage());
      case '/PinChangeSetup':
        return MaterialPageRoute(builder: (_) => PinChangeSetupPage());
      case '/PinChangeConfirm':
        return MaterialPageRoute(builder: (_) => PinChangeConfirmPage(routeArgument: args as RouteArgument));
        
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case '/TopUp':
        return MaterialPageRoute(builder: (_) => TopUpPage());
      // case '/SimlaTopUpReview':
      //   return MaterialPageRoute(builder: (_) => TopUpReviewPage(routeArgument: args as RouteArgument));
      case '/SimlaTransfer':
        return MaterialPageRoute(builder: (_) => SimlaTransferPage());
      case '/SimlaTransferInfo':
        return MaterialPageRoute(builder: (_) => SimlaTransferInfoPage(routeArgument: args as RouteArgument));
      case '/SimlaTransferConfirm':
        return MaterialPageRoute(builder: (_) => SimlaTransferConfirmPage(routeArgument: args as RouteArgument));
      case '/SimlaRiwayat':
        return MaterialPageRoute(builder: (_) => RiwayatSimlaPage());
      case '/SimlaScan':
        return MaterialPageRoute(builder: (_) => SimlaScanPage());
      case '/SimlaPin':
        return MaterialPageRoute(builder: (_) => SimlaPinPage(routeArgument: args as RouteArgument));


        
      case '/Tagihan':
        return MaterialPageRoute(builder: (_) => TagihanPage());
      case '/TagihanSimpananDetail':
        return MaterialPageRoute(builder: (_) => TagihanSimpananDetailPage(routeArgument: args as RouteArgument));

        
      case '/Notifikasi':
        return MaterialPageRoute(builder: (_) => NotificationPage());

      
      case '/PaymentMethod':
        return MaterialPageRoute(builder: (_) => PaymentMethodPage(routeArgument: args as RouteArgument));
      case '/PaymentConfirm':
        return MaterialPageRoute(builder: (_) => PaymentConfirmPage(routeArgument: args as RouteArgument));
      
      case '/Transaksi':
        return MaterialPageRoute(builder: (_) => TransaksiPage());
      case '/TransaksiDetail':
        return MaterialPageRoute(builder: (_) => TransaksiDetailPage(routeArgument: args as RouteArgument));

      case '/Simpanan':
        return MaterialPageRoute(builder: (_) => SimpananPage());
      case '/SimpananDetail':
        return MaterialPageRoute(builder: (_) => SimpananDetailPage(routeArgument: args as RouteArgument));
      case '/SimpananRiwayat':
        return MaterialPageRoute(builder: (_) => SimpananRiwayatPage(routeArgument: args as RouteArgument));
        
      case '/Pembiayaan':
        return MaterialPageRoute(builder: (_) => PembiayaanPage());
      case '/PembiayaanProgram':
        return MaterialPageRoute(builder: (_) => PembiayaanDetailPage(routeArgument: args as RouteArgument));
      case '/PembiayaanTunai':
        return MaterialPageRoute(builder: (_) => PembiayaanTunaiPage(routeArgument: args as RouteArgument));
      case '/PembiayaanTunaiDetail':
        return MaterialPageRoute(builder: (_) => PembiayaanTunaiDetailPage(routeArgument: args as RouteArgument));

        
      case '/PembiayaanBayar':
        return MaterialPageRoute(builder: (_) => PembiayaanBayarPage(routeArgument: args as RouteArgument));


        
      case '/PulsaData':
        return MaterialPageRoute(builder: (_) => PulsaPage(routeArgument: args as RouteArgument));

      
      case '/SHU':
        return MaterialPageRoute(builder: (_) => SHUPage());

      
      case '/Lainnya':
        return MaterialPageRoute(builder: (_) => ServicesPage());

      case '/Account':
        return MaterialPageRoute(builder: (_) => AccountPage());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
