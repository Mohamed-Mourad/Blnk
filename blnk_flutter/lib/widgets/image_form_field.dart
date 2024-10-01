import 'package:blnk_flutter/methods/navigations.dart';
import 'package:blnk_flutter/screens/id_viewer.dart';
import 'package:flutter/material.dart';

class ImageFormField extends StatelessWidget {

  final String text;
  final String path;

  const ImageFormField({
    super.key,
    required this.text,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, IdViewer(title: text, path: path));
      },
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE2ECF7),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.image_outlined,
              color: Color(0xFF333333),
            ),
            const SizedBox(width: 5.0,),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Color(0xFF217FEB),
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF217FEB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
