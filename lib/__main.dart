import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import './ffi/generated_bindings.dart';

void main() {
  final dylib =
      DynamicLibrary.open("F:\\libharu\\native\\build\\src\\Debug\\hpdf.dll");
  final cjson = LibHaru(dylib);
  HPDF_Error_Handler user_error_fn = nullptr;
  Pointer<Void> user_data = nullptr as Pointer<Void>;
  var pdf = cjson.HPDF_New(user_error_fn, user_data);
  var page = cjson.HPDF_AddPage(pdf);
  double height;
  double width;
  height = cjson.HPDF_Page_GetHeight(page);
  width = cjson.HPDF_Page_GetWidth(page);
  cjson.HPDF_Page_SetLineWidth(page, 1);
  cjson.HPDF_Page_Rectangle(page, 50, 50, width - 100, height - 110);
  cjson.HPDF_Page_Stroke(page);
  Pointer<Char> text = "Helvetica".toNativeUtf8() as Pointer<Char>;
  var def_font = cjson.HPDF_GetFont(pdf, text, nullptr);
  cjson.HPDF_Page_SetFontAndSize(page, def_font, 24);
  Pointer<Char> page_title = "Font Demo".toNativeUtf8() as Pointer<Char>;
  ;
  var tw = cjson.HPDF_Page_TextWidth(page, page_title);
  cjson.HPDF_Page_BeginText(page);
  cjson.HPDF_Page_TextOut(page, (width - tw) / 2, height - 50, page_title);
  cjson.HPDF_Page_EndText(page);
  final Pointer<Char> fileNameUtf8 =
      "hello.pdf".toNativeUtf8() as Pointer<Char>;

  final Pointer<Utf8> strUtf8 = "hello.pdf".toNativeUtf8() as Pointer<Utf8>;
  cjson.HPDF_SaveToFile(pdf, fileNameUtf8);
  cjson.HPDF_Free(pdf);
  print('$width, $height');
}
