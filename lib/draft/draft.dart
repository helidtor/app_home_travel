// gọi api dạng multipart
// static Future<bool?> signup(
//       {required UserSignUpModel userSignUpModel}) async {
//     try {
//       final url = Uri.parse('$baseUrl/api/v1/Tourists');
//       Map<String, String> header = await ApiHeader.getHeader();

//       var request = http.MultipartRequest('POST', url);

//       // Add headers
//       header.forEach((key, value) {
//         request.headers[key] = value;
//       });

//       // Add fields
//       request.fields['dateOfBirth'] = userSignUpModel.dateOfBirth!;
//       request.fields['password'] = userSignUpModel.password!;
//       request.fields['gender'] = userSignUpModel.gender!.toString();
//       request.fields['phoneNumber'] = userSignUpModel.phoneNumber!;
//       request.fields['email'] = userSignUpModel.email!;
//       request.fields['firstName'] = userSignUpModel.firstName!;
//       request.fields['lastName'] = userSignUpModel.lastName!;
//       request.fields['avatar'] = userSignUpModel.avatar!;
//       var response = await http.Response.fromStream(await request.send());

//       if (response.statusCode == 200) {
//         print(
//             "Đăng ký thành công! ${response.statusCode} ${jsonDecode(response.body)}");
//         return true;
//       } else {
//         print(
//             "Đăng ký không thành công! ${response.statusCode} ${response.body}");
//         return false;
//       }
//     } catch (e) {
//       print("Lỗi đăng ký: $e");
//       return false;
//     }
//   }