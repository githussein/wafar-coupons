import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coupons_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/store_coupons_listview.dart';

class StoreCouponsScreen extends StatefulWidget {
  static const routeName = '/store_coupons';
  @override
  _StoreCouponsScreenState createState() => _StoreCouponsScreenState();
}

class _StoreCouponsScreenState extends State<StoreCouponsScreen> {
//manage state
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CouponsProvider>(context, listen: false)
          .fetchCoupons() //fetch coupons data
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          'Store Coupons',
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : StoreCouponsListview(),
    );
  }
}
