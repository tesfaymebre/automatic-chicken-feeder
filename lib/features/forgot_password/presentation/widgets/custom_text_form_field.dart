import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage(
      {Key? key,
      required this.errorText,
      this.icon = Icons.error_outline_rounded})
      : super(key: key);
  final String errorText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.red,
          size: screenHeight * 0.022,
        ),
        SizedBox(
          width: screenHeight * 0.0064,
        ),
        Flexible(
          child: Text(
            errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: screenHeight * 0.017,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}

class CustomTextFormField extends FormField<String> {
  CustomTextFormField(
      {Key? key,
      this.controller,
      String? initialValue,
      FocusNode? focusNode,
      InputDecoration? decoration = const InputDecoration(),
      TextInputType? keyboardType,
      TextCapitalization textCapitalization = TextCapitalization.none,
      TextInputAction? textInputAction,
      TextStyle? style,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      TextAlign textAlign = TextAlign.start,
      TextAlignVertical? textAlignVertical,
      bool autofocus = false,
      bool readOnly = false,
      ToolbarOptions? toolbarOptions,
      bool? showCursor,
      String obscuringCharacter = '•',
      bool obscureText = false,
      bool autocorrect = true,
      SmartDashesType? smartDashesType,
      SmartQuotesType? smartQuotesType,
      bool enableSuggestions = true,
      MaxLengthEnforcement? maxLengthEnforcement,
      int? maxLines = 1,
      int? minLines,
      bool expands = false,
      int? maxLength,
      ValueChanged<String>? onChanged,
      GestureTapCallback? onTap,
      VoidCallback? onEditingComplete,
      ValueChanged<String>? onFieldSubmitted,
      FormFieldSetter<String>? onSaved,
      FormFieldValidator<String>? validator,
      List<TextInputFormatter>? inputFormatters,
      bool? enabled,
      double cursorWidth = 2.0,
      double? cursorHeight,
      Radius? cursorRadius,
      Color? cursorColor,
      Brightness? keyboardAppearance,
      EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
      bool enableInteractiveSelection = true,
      TextSelectionControls? selectionControls,
      InputCounterWidgetBuilder? buildCounter,
      ScrollPhysics? scrollPhysics,
      Iterable<String>? autofillHints,
      AutovalidateMode? autovalidateMode,
      ScrollController? scrollController,
      IconData errorIcon = Icons.error_outline_rounded})
      : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength > 0),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: (autovalidateMode ?? AutovalidateMode.disabled),
          builder: (FormFieldState<String> field) {
            final _CustomTextFormFieldState state =
                field as _CustomTextFormFieldState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }
            
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: state._effectiveController,
                    focusNode: focusNode,
                    decoration: effectiveDecoration,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    style: style,
                    strutStyle: strutStyle,
                    textAlign: textAlign,
                    textAlignVertical: textAlignVertical,
                    textDirection: textDirection,
                    textCapitalization: textCapitalization,
                    autofocus: autofocus,
                    toolbarOptions: toolbarOptions,
                    readOnly: readOnly,
                    showCursor: showCursor,
                    obscuringCharacter: obscuringCharacter,
                    obscureText: obscureText,
                    autocorrect: autocorrect,
                    smartDashesType: smartDashesType ??
                        (obscureText
                            ? SmartDashesType.disabled
                            : SmartDashesType.enabled),
                    smartQuotesType: smartQuotesType ??
                        (obscureText
                            ? SmartQuotesType.disabled
                            : SmartQuotesType.enabled),
                    enableSuggestions: enableSuggestions,
                    maxLengthEnforcement: maxLengthEnforcement,
                    maxLines: maxLines,
                    minLines: minLines,
                    expands: expands,
                    maxLength: maxLength,
                    onChanged: onChangedHandler,
                    onTap: onTap,
                    onEditingComplete: onEditingComplete,
                    onSubmitted: onFieldSubmitted,
                    inputFormatters: inputFormatters,
                    enabled: enabled ?? decoration?.enabled ?? true,
                    cursorWidth: cursorWidth,
                    cursorHeight: cursorHeight,
                    cursorRadius: cursorRadius,
                    cursorColor: cursorColor,
                    scrollPadding: scrollPadding,
                    scrollPhysics: scrollPhysics,
                    keyboardAppearance: keyboardAppearance,
                    enableInteractiveSelection: enableInteractiveSelection,
                    selectionControls: selectionControls,
                    buildCounter: buildCounter,
                    autofillHints: autofillHints,
                    scrollController: scrollController,
                  ),
                ),
                SizedBox(height: 5.0),
                field.hasError
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _ErrorMessage(
                          errorText: field.errorText!,
                          icon: errorIcon,
                        ),
                      )
                    : Container(),
              ],
            );
          },
        );

  final TextEditingController? controller;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  @override
  CustomTextFormField get widget => super.widget as CustomTextFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController!.text != value)
      _effectiveController!.text = value ?? '';
  }

  @override
  void reset() {
    _effectiveController!.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value)
      didChange(_effectiveController!.text);
  }
}
