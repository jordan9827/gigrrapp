part of mapbox_search;

class CustomTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextInputType inputType;
  final TextEditingController? textController;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final TextInputAction keyboardAction;
  final FocusNode? focusNode;
  final Function? validator;
  final Function()? actionSuffixIcon;
  final Function? onSaved;
  final Function? onTap;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? onEditComplete;

  CustomTextField({
    required this.hintText,
    this.initialValue,
    this.textController,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.actionSuffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines,
    this.keyboardAction = TextInputAction.next,
    this.focusNode,
    this.validator,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 2),
              blurRadius: 5,
              color: Colors.grey.shade400,
            )
          ],
        ),
        child: TextFormField(
          controller: textController,
          focusNode: focusNode,
          textAlign: TextAlign.start,
          onChanged: onChanged as void Function(String)?,
          onFieldSubmitted: onFieldSubmitted as void Function(String)?,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: textController!.text.isNotEmpty
                ? InkWell(
                    onTap: actionSuffixIcon,
                    child: Icon(
                      Icons.clear,
                      size: 20,
                      color: Colors.black,
                    ),
                  )
                : null,
            prefixIcon: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.search,
                size: 20,
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
