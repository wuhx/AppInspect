import 'dart:html';

class Download {
  static void download(String url) {
    final anchor = AnchorElement(href: url)..target = 'blank';
    // add the name
    // if (downloadName != null) {
    // anchor.download = "thisis.pdf";
    // }
    // trigger download
    document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }
}
