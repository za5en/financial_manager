import 'package:flutter/material.dart';

class FSearchLine extends StatefulWidget {
  const FSearchLine({super.key, this.onSearchChanged, this.onSearchReset});
  final void Function(String)? onSearchChanged;
  final void Function()? onSearchReset;

  @override
  State<FSearchLine> createState() => _FSearchLineState();
}

class _FSearchLineState extends State<FSearchLine> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.062,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(202, 196, 208, 1)),
        ),
        color: Color.fromRGBO(236, 230, 240, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (value) => widget.onSearchChanged!(value),
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Найти статью',
                suffixIcon: Icon(
                  Icons.search_outlined,
                  color: Color.fromRGBO(73, 69, 79, 1),
                ),
                contentPadding: EdgeInsets.only(
                  left: w * 0.05,
                  right: w * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
