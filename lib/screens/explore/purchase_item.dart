import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/explore/store_items.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:ds_market_place/states/purchase_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseItemScreen extends ConsumerStatefulWidget {
  final StoreItem item;
  const PurchaseItemScreen(this.item, {Key? key}) : super(key: key);

  @override
  _PurchaseItemScreenState createState() => _PurchaseItemScreenState();
}

class _PurchaseItemScreenState extends ConsumerState<PurchaseItemScreen>
    with TickerProviderStateMixin {
  late AnimationController minusController;
  late AnimationController plusController;
  late AnimationController amountController;
  int amount = 1;
  final Duration duration = Duration(milliseconds: 100);
  TextStyle amountTextStyle = TextStyle(color: Colors.black);

  @override
  void initState() {
    super.initState();
    minusController = AnimationController(vsync: this, duration: duration);
    plusController = AnimationController(vsync: this, duration: duration);
    amountController = AnimationController(vsync: this, duration: duration);
  }

  void _increaseAmount() async {
    setState(() {
      amount++;
      amountTextStyle = TextStyle(color: Colors.green);
    });
    await plusController.forward();
    plusController.reverse();
    setState(() {
      amountTextStyle = TextStyle(color: Colors.black);
    });
  }

  void _decreaseAmount() async {
    setState(() {
      if (amount - 1 >= 1) amount--;
      amountTextStyle = TextStyle(color: Colors.red);
    });
    await minusController.forward();
    minusController.reverse();
    setState(() {
      amountTextStyle = TextStyle(color: Colors.black);
    });
  }

  void submitAddToMyStore(String id) async {
    ref.read(itemEditProvider.notifier).addItemInOtherStoreToMyStore(id);
  }

  void submitPurchase(String id) async {
    PurchaseStoreItemRequest request = PurchaseStoreItemRequest(amount: amount);
    ref.read(purchaseProvider.notifier).purchaseStoreItem(id, request);
  }

  Table _buildTable() {
    StoreItem item =
        ref.watch(exploreProvider.notifier).getItemFromState(widget.item.id!) ??
            widget.item;
    return Table(
      children: [
        tableRow("Name: ", item.name, context),
        tableRow("", "", context),
        tableRow("Description: ", item.description, context),
        tableRow("", "", context),
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(left: 66.w),
            child: Text("Seller: ",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 13.sp,
                    )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => StoreDetailsScreen(
                          storeName: item.storeName,
                          storeId: item.storeId,
                        )));
              },
              child: Text(item.storeName,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xFF487E89),
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
        tableRow("", "", context),
        tableRow("Available amount: ", item.amount.toString(), context),
        tableRow("", "", context),
        tableRow("Price: ", "\$${item.price.toStringAsFixed(2)}", context),
      ],
    );
  }

  Widget _buildPurchaseButton() {
    return Center(
      child: Builder(
        builder: (context) {
          final state = ref.watch(purchaseProvider);
          if (state is PurchaseLoadingState) {
            return CircularProgressIndicator();
          } else if (state is PurchaseErrorState) {
            return MyErrorWidget(
              failure: state.failure,
              onRetry: () => submitPurchase(widget.item.id!),
            );
          } else {
            // inital - loaded
            return RoundedButton(
              title: "Purchase",
              onPressed: () => submitPurchase(widget.item.id!),
            );
          }
        },
      ),
    );
  }

  Widget _buildAddToMyStoreButton() {
    return Center(
      child: Builder(
        builder: (context) {
          final state = ref.watch(itemEditProvider);
          if (state is ItemEditLoadingState) {
            return CircularProgressIndicator(color: Colors.orange);
          } else if (state is ItemEditErrorState) {
            return MyErrorWidget(
              failure: state.failure,
              onRetry: () => submitAddToMyStore(widget.item.id!),
              color: Colors.orange,
            );
          } else {
            // inital - loaded
            return RoundedButton(
              title: "Add To My Store",
              onPressed: () => submitAddToMyStore(widget.item.id!),
              color: Colors.orange,
            );
          }
        },
      ),
    );
  }

  Widget _buildAmountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.25).animate(minusController),
          child: RoundedButton(
            title: "-",
            onPressed: _decreaseAmount,
            large: false,
          ),
        ),
        SizedBox(width: 8.w),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 94.w),
          child: AnimatedDefaultTextStyle(
            duration: duration,
            style: amountTextStyle,
            child: ScaleTransition(
              scale:
                  Tween<double>(begin: 1.0, end: 0.75).animate(minusController),
              child: ScaleTransition(
                scale: Tween<double>(begin: 1.0, end: 1.75)
                    .animate(plusController),
                child: Text(
                  amount.toString(),
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.25).animate(plusController),
          child: RoundedButton(
            title: "+",
            onPressed: _increaseAmount,
            large: false,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(purchaseProvider, (previous, next) {
      if (next is PurchaseLoadedState &&
          (ModalRoute.of(context)?.isCurrent ?? false)) {
        String message =
            "$amount" "X of ${widget.item.name} is purchased succesfully";
        showSnackbar(context, Text(message));
        Navigator.of(context).pop();
      }
    });
    ref.listen(itemEditProvider, (previous, next) {
      if (next is ItemEditLoadedState &&
          (ModalRoute.of(context)?.isCurrent ?? false)) {
        showSnackbar(context,
            Text("${widget.item.name} is added to your store succesfully"));
        Navigator.of(context).pop();
      }
    });
    StoreItem item = widget.item;
    return WillPopScope(
      onWillPop: () {
        // multiple purchase screens could be stacked over each other.
        // all of them use the same set of providers.
        // refresh provider when screen is poped so that errors from popped
        // screen would not show on screens below it in the stack because of the
        // provider preserving of state between screens.
        ref.refresh(purchaseProvider);
        ref.refresh(itemEditProvider);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(item.name),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 33.w, top: 23.h, bottom: 59.h),
              child: Row(
                children: [
                  MyCachedImg(
                    item.imageLink,
                    164.w,
                    134.h,
                  ),
                ],
              ),
            ),
            _buildTable(),
            59.verticalSpace,
            if (item.storeName != globals.storeName)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      "Amount",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  _buildAmountWidget(),
                  SizedBox(height: 22.h),
                  _buildPurchaseButton(),
                  SizedBox(height: 15.h),
                  _buildAddToMyStoreButton(),
                  SizedBox(height: 20.h),
                ],
              )
          ],
        ),
      ),
    );
  }
}
