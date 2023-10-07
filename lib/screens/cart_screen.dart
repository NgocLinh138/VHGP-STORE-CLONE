import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:store_app/apis/apiService.dart';
import 'package:store_app/constants/Theme.dart';
import 'package:store_app/models/cartModel.dart';
import 'package:store_app/provider/appProvider.dart';
import 'package:store_app/routes.dart';
import 'package:store_app/screens/login_screen.dart';
import 'package:store_app/screens/profile_screen.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:intl/intl.dart';
import 'package:store_app/widgets/color/colors.dart';
import 'package:store_app/widgets/accordion/accordion_menu_item.dart';

// import 'dart:async';

import 'package:store_app/widgets/accordion/accordion_menu_item.dart';
import 'package:store_app/widgets/screen/cart_add_product.dart';
import 'package:store_app/widgets/screen/font_awesome_flutter.dart';
import 'package:store_app/widgets/screen/user_info.dart';
import 'package:store_app/widgets/title/tab_title_uncount.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late String deliveryMode = "GIAO NHANH 30 PHÚT";
  late Cart cartController;
  final AppProvider controller = AppProvider();

  final String deliveryMode2 = "GIAO HÀNG TRONG NGÀY";
  final NumberFormat viCurrency = NumberFormat('#,##0 ₫', 'vi_VN');
  String enteredAddress = "Giao đến đâu";

  @override
  void initState() {
    controller.getAddress();
    cartController = context.read<AppProvider>().cart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "SF Bold",
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 159, 56),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Giao đến',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              final appProvider = context.read<AppProvider>();
                              appProvider.getAreaList();
                              appProvider.getAddress();
                              Navigator.pushReplacementNamed(
                                  context, '/create-order');
                              setState(() {
                                enteredAddress = context
                                    .read<AppProvider>()
                                    .addressList
                                    .toString();
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 5),
                                      child: Row(
                                        children: [
                                          ShaderMask(
                                            shaderCallback: (Rect bounds) {
                                              return const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 250, 159, 56),
                                                  Color(0xfff7892b)
                                                ],
                                              ).createShader(bounds);
                                            },
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            enteredAddress,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Được giao từ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              GestureDetector(
                                onTap: () {
                                  context.read<AppProvider>().getAreaList();
                                  context.read<AppProvider>().getAddress();
                                  Navigator.pushReplacementNamed(
                                      context, '/create-order');
                                },
                                child: Text(
                                    '${context.read<AppProvider>().storeModel.name}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Hình thức giao hàng',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              Text(deliveryMode,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // TabTitleUnCount(
                  //     title: "Thông tin người nhận",
                  //     actionText: "Thay đổi",
                  //     seeAll: () => Navigator.pushReplacementNamed(
                  //         context, '/create-order')),
                  // _buildInformation(context),
                  // const TabTitleUnCount(title: "Tóm tắt đơn hàng"),
                  // _buildOrderProductDetail(),
                  // _buildeDelivery(context),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 15.0, vertical: 15),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text('Tiền hàng:',
                  //               style: TextStyle(fontSize: 25)),
                  //           Text(
                  //               viCurrency.format(
                  //                   context.read<AppProvider>().cart.total),
                  //               style: const TextStyle(fontSize: 25)),
                  //         ],
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             const Text('Phí giao hàng:',
                  //                 style: TextStyle(fontSize: 15)),
                  //             Text(
                  //                 viCurrency.format(
                  //                   context.read<AppProvider>().deliveryFee,
                  //                 ),
                  //                 style: const TextStyle(fontSize: 25)),
                  //           ],
                  //         ),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text('Phí dịch vụ',
                  //               style: TextStyle(fontSize: 15)),
                  //           Text(
                  //               viCurrency.format(context
                  //                       .read<AppProvider>()
                  //                       .isCheck
                  //                   ? context.read<AppProvider>().servicesFee
                  //                   : 0),
                  //               style: const TextStyle(fontSize: 15)),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/moneys.png",
                              height: 20,
                            ),
                            const Text(
                              'Tiền mặt',
                              style: TextStyle(fontSize: 18),
                            ),
                            const ImageIcon(
                              AssetImage("assets/images/arrow_user.png"),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tổng cộng:',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              viCurrency.format(
                                  context.read<AppProvider>().cart.total +
                                      context.read<AppProvider>().deliveryFee),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      if (context.read<AppProvider>().optionTimeList.isEmpty ||
                          cartController.deliveryTime == "Chọn khung giờ")
                        const Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            "Chưa chọn khung giờ giao hàng",
                            style: TextStyle(
                                color: Color.fromRGBO(217, 48, 37, 1)),
                          ),
                        ),
                      InkWell(
                        onTap: (context
                                    .read<AppProvider>()
                                    .optionTimeList
                                    .isEmpty ||
                                context
                                    .read<AppProvider>()
                                    .cart
                                    .orderDetail
                                    .isEmpty)
                            ? null
                            : () {
                                if (context.read<AppProvider>().cart.fullName ==
                                        null ||
                                    context
                                            .read<AppProvider>()
                                            .cart
                                            .fullName ==
                                        '' ||
                                    context
                                            .read<AppProvider>()
                                            .cart
                                            .phoneNumber ==
                                        null ||
                                    context
                                            .read<AppProvider>()
                                            .cart
                                            .phoneNumber ==
                                        '' ||
                                    context.read<AppProvider>().deliveryTime ==
                                        "Chọn khung giờ") {
                                  showErrorAlertDialog(context);
                                } else {
                                  builderConfirmOrder(context);
                                }
                              },
                        child: Container(
                          child: Text(
                            'Đặt hàng',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: (context
                                        .read<AppProvider>()
                                        .optionTimeList
                                        .isEmpty
                                    ? [
                                        Color.fromRGBO(228, 227, 227, 1),
                                        Color.fromRGBO(194, 192, 192, 1)
                                      ]
                                    : [
                                        primary,
                                        primary2,
                                      ]),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOrderProductDetail() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartController.orderDetail.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   height: 48,
              //   width: 48,
              //   child: AccordionMenuItem(
              //     imageUrl: cartController.orderDetail[index].imageUrl ?? '',
              //     imageBuilder: (context, imageProvider) => Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8),
              //         image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Text(
                'x${context.read<AppProvider>().cart.orderDetail[index].quantity}',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${context.read<AppProvider>().cart.orderDetail[index].productName}',
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: TextButton(
                            onPressed: () {
                              context.read<AppProvider>().showUpdateQuantity(
                                  context
                                      .read<AppProvider>()
                                      .cart
                                      .orderDetail[index]
                                      .productId);
                              _showUpdateProduct(
                                  context,
                                  context
                                      .read<AppProvider>()
                                      .cart
                                      .orderDetail[index]);
                            },
                            child: const Text('Chỉnh sửa',
                                style: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ]),
                ),
              ),
              Text(
                viCurrency.format(cartController.orderDetail[index].price),
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildInformation(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              UserInformation(
                cartController: cartController,
                label: 'Tên người nhận',
                value: context.read<AppProvider>().cart.fullName ?? '',
                faIcon: FontAwesomeIcons.solidUser,
              ),
              UserInformation(
                cartController: cartController,
                label: 'Số điện thoại',
                value: context.read<AppProvider>().cart.phoneNumber ?? '',
                faIcon: FontAwesomeIcons.phone,
              ),
              InkWell(
                onTap: () => _showWarning(context),
                child: UserInformation(
                  cartController: cartController,
                  label: 'Lưu ý',
                  value: context.read<AppProvider>().cart.note ?? '',
                  faIcon: FontAwesomeIcons.clipboard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildeDelivery(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: context.read<AppProvider>().isCheck,
                  onChanged: (bool? value) {
                    context.read<AppProvider>().setCheck();
                  },
                ),
                // SizedBox(
                //   height: 32,
                //   width: 32,
                //   child: CachedNetworkImage(
                //     imageUrl:
                //         'https://cdn-icons-png.flaticon.com/512/2844/2844235.png',
                //     imageBuilder: (context, imageProvider) => Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         image: DecorationImage(
                //           image: imageProvider,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hỏa tốc',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Text(
                          'Đơn hàng của bạn đang được ưu tiên để tài xế giao sớm nhất.',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
              ],
            ),
            Text(viCurrency.format(context.read<AppProvider>().servicesFee),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  Future<String?> _showUpdateProduct(BuildContext context, dynamic product) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: const Text(
            "Cập nhật giỏ hàng",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.productName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(82, 182, 91, 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      viCurrency.format(product.price),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(82, 182, 91, 1)),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2,
                    child: CartAddProduct(
                      product: product,
                      isCartScreen: true,
                    ),
                  )
                ],
              )),
          actions: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  if (context.read<AppProvider>().quantity >= 1) {
                    context
                        .read<AppProvider>()
                        .changeQuantity(product.productId);
                  } else {
                    context
                        .read<AppProvider>()
                        .deleteProduct(product.productId);
                  }

                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: context.read<AppProvider>().quantity >= 1
                                ? [
                                    primary,
                                    primary2,
                                  ]
                                : [
                                    Color.fromRGBO(237, 55, 116, 1),
                                    Color.fromRGBO(237, 55, 116, 1),
                                  ])),
                    child: context.read<AppProvider>().quantity >= 1
                        ? const Text(
                            'Cập nhật giỏ hàng',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "SF Bold",
                            ),
                          )
                        : const Text(
                            'Hủy',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "SF Bold",
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  Future<String?> _showWarning(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: const Text("Lưu ý đặc biệt"),
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: context.read<AppProvider>().noteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  ),
                ),
              )),
          actions: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  context.read<AppProvider>().createNote();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            primary,
                            primary2,
                          ])),
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "SF Bold",
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> showAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/successful.gif",
                    width: 300, fit: BoxFit.cover),
                const Text("Đặt hàng thành công",
                    style: TextStyle(fontSize: 25)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Mã đơn hàng của bạn là ",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      Text(context.read<AppProvider>().deliveryCode,
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text('Bạn có thể dùng nó để theo dõi đơn hàng của mình.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> builderConfirmOrder(BuildContext parentContext) {
    int _start = 10;
    return showDialog<String>(
      context: parentContext,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              --_start;
            });
            if (_start == 0) {
              Navigator.pop(context);
              context.read<AppProvider>().submitOrder().then((value) {
                if (!context.read<AppProvider>().isLoading) {
                  if (context.read<AppProvider>().status == 200) {
                    showAlertDialog(parentContext);
                  } else {
                    showErrorAlertDialog(parentContext);
                  }
                }
              });
            }
          });
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child:
                          Text("Đơn hàng sẽ được gửi đi trong\n$_start giây...",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                              )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Giao đến",
                          style: TextStyle(fontSize: 15),
                        ),
                        Expanded(
                          child: Text(
                              '${context.read<AppProvider>().cart.buildingName}, ${context.read<AppProvider>().areaName} Vinhomes GP',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Thời gian dự kiến: ",
                            style: TextStyle(fontSize: 15)),
                        Expanded(
                          child: Text(
                            '${context.read<AppProvider>().deliveryTime}',
                            style: const TextStyle(fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Tổng tiền đơn hàng: ",
                            style: TextStyle(fontSize: 18)),
                        Text(
                            viCurrency.format(
                                context.read<AppProvider>().cart.total +
                                    context.read<AppProvider>().deliveryFee),
                            style: const TextStyle(fontSize: 18))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child:
                          const Text('Trở lại', style: TextStyle(fontSize: 15)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context
                              .read<AppProvider>()
                              .submitOrder()
                              .then((value) {
                            if (!context.read<AppProvider>().isLoading) {
                              if (context.read<AppProvider>().status == 200) {
                                showAlertDialog(parentContext);
                              } else {
                                showErrorAlertDialog(parentContext);
                              }
                            }
                          });
                        },
                        child: const Text('Tiếp tục',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<String?> showOptionTimesEmptyAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/error.png",
                        width: 250, fit: BoxFit.cover),
                    const Text(
                      "Oops...!",
                      style: TextStyle(
                          color: Color.fromRGBO(237, 55, 116, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Không có khung giờ phụ hợp. Vui lòng thử lại sau.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(237, 55, 116, 1),
                                Color.fromRGBO(237, 55, 116, 1),
                              ])),
                      child: const Text(
                        'Đóng',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "SF Bold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> showErrorAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/error.png",
                        width: 300, fit: BoxFit.cover),
                    const Text(
                      "Oops...!",
                      style: TextStyle(
                          color: Color.fromRGBO(237, 55, 116, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Đã xảy ra lỗi gì đó. Vui lòng thử lại sau.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(237, 55, 116, 1),
                                Color.fromRGBO(237, 55, 116, 1),
                              ])),
                      child: const Text(
                        'Đóng',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "SF Bold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTimePickerPicker() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 180,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 64,
        onSelectedItemChanged: (value) =>
            context.read<AppProvider>().changeOptionTime(value),
        children: context
            .read<AppProvider>()
            .optionTimeList
            .map(
              (e) => Center(
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
