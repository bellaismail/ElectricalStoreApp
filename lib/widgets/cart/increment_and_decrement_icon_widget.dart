
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/cart_screen_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import '../../constant.dart';

class IncrementAndDecrementIcon extends StatefulWidget {
  IncrementAndDecrementIcon({required this.num, required this.uniqueKey, required this.onConfirmFun, required this.productViewModel});

  final int num;
  final String uniqueKey;
  final Future<bool?> Function(DismissDirection)? onConfirmFun;
  final ProductViewModel productViewModel;

  @override
  State<IncrementAndDecrementIcon> createState() =>
      _IncrementAndDecrementIconState();
}

class _IncrementAndDecrementIconState extends State<IncrementAndDecrementIcon> {
  bool show = false;
  bool onTap = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap?() async {
        setState(() {
          show = true;
          onTap = false;
        });
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          show = false;
          onTap = true;
        });
      }:null,
      child: show
          ? const _ShowIncrementAnDecrementWidget()
          : Dismissible(
              key: Key(widget.uniqueKey),
              direction: DismissDirection.vertical,
              confirmDismiss: widget.onConfirmFun!,
              child: _IncrementAnDecrementWidget(num: widget.num, productViewModel: widget.productViewModel),
            ),
    );
  }
}

class _ShowIncrementAnDecrementWidget extends StatelessWidget {
  const _ShowIncrementAnDecrementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: kTextColor,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "+",
              style: TextStyle(
                color: kTextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "-",
              style: TextStyle(
                color: kTextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IncrementAnDecrementWidget extends StatefulWidget {
  _IncrementAnDecrementWidget({Key? key, required this.num, required this.productViewModel})
      : super(key: key);
  final int num;
  final ProductViewModel productViewModel;

  @override
  State<_IncrementAnDecrementWidget> createState() => _IncrementAnDecrementWidgetState();
}

class _IncrementAnDecrementWidgetState extends State<_IncrementAnDecrementWidget> {
  int? counter = 1;
  UserRepository userRepository = UserRepoFirebase();
  getNumOfEachProduct()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    counter = s.getInt("${userRepository.getCurrentUserId()}${widget.productViewModel.id}count")??1;
  }

  @override
  void initState() {
    getNumOfEachProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartScreenViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: kTextColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        "x${counter}",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}


// class _IncrementAnDecrementWidget extends StatelessWidget {
//   _IncrementAnDecrementWidget({Key? key, required this.num})
//       : super(key: key);
//   final int num;
//   int counter = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(15.0),
//       decoration: const BoxDecoration(
//         color: kTextColor,
//         shape: BoxShape.circle,
//       ),
//       child: Text(
//         "x$counter",
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }