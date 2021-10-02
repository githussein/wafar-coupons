import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/coupon.dart';
import '../providers/coupons_provider.dart';
import '../widgets/app_drawer.dart';
import 'store_coupons_screen.dart';

class CategorizedStoresScreen extends StatefulWidget {
  static const routeName = '/categorized_stores';
  @override
  _CategorizedStoresScreenState createState() =>
      _CategorizedStoresScreenState();
}

class _CategorizedStoresScreenState extends State<CategorizedStoresScreen> {
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).stores),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : StoresListView(),
    );
  }
}

class StoresListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String categoryName =
        ModalRoute.of(context).settings.arguments as String; //the category

    //access the coupon data
    //instance of the coupons provider
    final couponsData = Provider.of<CouponsProvider>(context);

    //list of all coupons
    final coupons = couponsData.items;
    // print(coupons.length);
    // //Remove duplications in the list, filter by store name
    // final filteredList = Set();
    // coupons.retainWhere((coup) => filteredList.add(coup.store));

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: coupons.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (ctx) => coupons[index],
        value: coupons[index],
        child: StoreItem(categoryName),
      ),
    );
  }
}

class StoreItem extends StatelessWidget {
  final String categoryName;
  StoreItem(this.categoryName);

  @override
  Widget build(BuildContext context) {
    print(categoryName);
    //listen once to the provider to get coupon object
    final coupon = Provider.of<Coupon>(context, listen: false);
    //filter stores by category
    return coupon.category.contains(categoryName)
        ? Container(
            margin: EdgeInsets.only(right: 10, left: 10, top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
              color: Colors.white70,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  StoreCouponsScreen.routeName,
                  arguments: coupon.store,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: Expanded(
                      child: Text(
                        coupon.store,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(coupon.imageUrl),
                    minRadius: 20,
                    maxRadius: 30,
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
