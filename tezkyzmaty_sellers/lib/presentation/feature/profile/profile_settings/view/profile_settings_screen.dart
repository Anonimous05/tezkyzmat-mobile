// // ignore_for_file: prefer_if_elements_to_conditional_expressions

// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
// import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
// import 'package:tezkyzmaty_sellers/core/theme/color.dart';
// import 'package:tezkyzmaty_sellers/core/theme/font.dart';
// import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
// import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
// import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';
// import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';
// import 'package:tezkyzmaty_sellers/presentation/feature/profile/profile_main/view/profile_screen.dart';
// import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';

// class ProfileSettingsScreen extends StatefulWidget {
//   const ProfileSettingsScreen({super.key});

//   @override
//   State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
// }

// class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
//   File? avatar;
//   Future<void> pickImages(ImageSource imageSource) async {
//     try {
//       final XFile? image = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//       );
//       if (image != null) {
//         setState(() {
//           avatar = File(image.path);
//         });
//         if (mounted) {
//           context.read<ProfileCubit>().updateAvatar(File(image.path));
//         }
//       }
//     } on PlatformException {
//       if (await Permission.camera.isPermanentlyDenied ||
//           await Permission.photos.isPermanentlyDenied ||
//           await Permission.camera.isDenied) {
//         if (mounted) {
//           CommonUtil.openSettingsImage(context);
//         }
//       }
//     }
//   }

//   Future<void> showPickImagePopup() {
//     return showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               onPressed: () async {
//                 Navigator.pop(context);

//                 await pickImages(ImageSource.gallery);
//               },
//               child: Text(
//                 'Media library',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 17.sp,
//                 ),
//               ),
//             ),
//             CupertinoActionSheetAction(
//               onPressed: () async {
//                 Navigator.pop(context);

//                 await pickImages(ImageSource.camera);
//               },
//               child: Text(
//                 'Camera',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 17.sp,
//                 ),
//               ),
//             ),
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             isDefaultAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text(
//               tr(LocaleKeys.cancel),
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 17.sp,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProfileCubit, ProfileState>(
//       listener: (context, state) {
//         if (state.status == ProfileStatus.loading) {
//           context.loaderOverlay.show();
//         }
//         if (state.status == ProfileStatus.failure) {
//           context.loaderOverlay.hide();
//           CommonUtil.showSnackBar(context, state.errorMessage, isError: true);
//         }

//         if (state.status == ProfileStatus.success) {
//           context.loaderOverlay.hide();
//         }
//         if (state.status == ProfileStatus.successUpdateAvatar) {
//           context.loaderOverlay.hide();

//           CommonUtil.showSnackBar(context, tr(LocaleKeys.profileAvatarChanged));
//         }
//       },
//       child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(forceMaterialTransparency: true),
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//                       child: Row(
//                         children: [
//                           Text(
//                             LocaleKeys.accountSettings,
//                             style: FontConstant.headingMediumTextStyleFont(
//                               color: TezColor.black,
//                             ),
//                           ).tr(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Center(
//                       child: TezMotion(
//                         onPressed: () {
//                           showPickImagePopup();
//                         },
//                         child: SizedBox(
//                           width: 130.r,
//                           height: 130.r,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               state.profile?.image != null && avatar == null
//                                   ? ClipOval(
//                                     child: CachedNetworkImage(
//                                       imageUrl: state.profile!.image!,
//                                       width: 120.r,
//                                       height: 120.r,
//                                       fit: BoxFit.cover,
//                                       progressIndicatorBuilder: (
//                                         context,
//                                         child,
//                                         loadingProgress,
//                                       ) {
//                                         return Shimmer(
//                                           color: TezColor.surfaceTertiary,
//                                           child: Container(
//                                             width: 120.r,
//                                             height: 120.r,
//                                             color: TezColor.surfaceTertiary,
//                                           ),
//                                         );
//                                       },
//                                       errorWidget: (
//                                         context,
//                                         error,
//                                         stackTrace,
//                                       ) {
//                                         return Container(
//                                           width: 120.r,
//                                           height: 120.r,
//                                           color: TezColor.surfaceTertiary,
//                                         );
//                                       },
//                                     ),
//                                   )
//                                   : avatar != null
//                                   ? ClipOval(
//                                     child: Image.file(
//                                       avatar!,
//                                       width: 120.r,
//                                       height: 120.r,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )
//                                   : SvgPicture.asset(
//                                     SVGConstant.icAvatar,
//                                     width: 120.r,
//                                     height: 120.r,
//                                     fit: BoxFit.fill,
//                                   ),
//                               Positioned(
//                                 top: 0,
//                                 right: 0,
//                                 child: Container(
//                                   width: 40.r,
//                                   height: 40.r,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withValues(
//                                           alpha: 0.1,
//                                         ),
//                                         blurRadius: 10,
//                                       ),
//                                       BoxShadow(
//                                         color: Colors.black.withValues(
//                                           alpha: 0.01,
//                                         ),
//                                         blurRadius: 1,
//                                       ),
//                                     ],
//                                   ),
//                                   child: SvgPicture.asset(
//                                     SVGConstant.icEdit,
//                                     width: 25.r,
//                                     height: 25.r,
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 32.h),
//                     ListItem(
//                       name: LocaleKeys.name,
//                       secondText: state.profile?.name ?? '',
//                       iconPath: '',
//                       onTap: () {
//                         context.pushNamed(RouterPath.changeName);
//                       },
//                     ),
//                     const Divider(color: TezColor.borderDisabled, height: 1),
//                     ListItem(
//                       name: LocaleKeys.email,
//                       secondText: state.profile?.email ?? '',
//                       iconPath: '',
//                       onTap: () {},
//                       isNeedChevron: false,
//                     ),
//                     const Divider(color: TezColor.borderDisabled, height: 1),
//                     ListItem(
//                       name: LocaleKeys.phoneNumber,
//                       secondText: state.profile?.phone ?? '',
//                       iconPath: '',
//                       onTap: () {},
//                       isNeedChevron: false,
//                     ),
//                     const Divider(color: TezColor.borderDisabled, height: 1),
//                     ListItem(
//                       name: LocaleKeys.yourPassword,
//                       secondText: tr(LocaleKeys.changePassword),
//                       iconPath: '',
//                       onTap: () {
//                         context.pushNamed(RouterPath.changePassword);
//                       },
//                     ),
//                     const Divider(color: TezColor.borderDisabled, height: 1),
//                     ListItem(
//                       name: LocaleKeys.deleteAccount,
//                       iconPath: '',
//                       isDelete: true,
//                       onTap: () {
//                         showDeleteAccount(context);
//                       },
//                     ),
//                     const Divider(color: TezColor.borderDisabled, height: 1),
//                     SizedBox(height: 24.h),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<dynamic> showDeleteAccount(BuildContext context) {
//     return showCupertinoDialog(
//       context: context,
//       barrierDismissible: true,
//       builder:
//           (BuildContext context) => CupertinoAlertDialog(
//             title:
//                 Text(
//                   LocaleKeys.areYouWantDeleteProfile,
//                   style: TextStyle(
//                     fontSize: 17.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ).tr(),
//             content: Padding(
//               padding: EdgeInsets.only(top: 8.0.h),
//               child:
//                   Text(
//                     LocaleKeys.thisActionCannotUndone,
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                     ),
//                   ).tr(),
//             ),
//             actions: [
//               CupertinoDialogAction(
//                 child:
//                     Text(
//                       LocaleKeys.cancel,
//                       style: TextStyle(
//                         fontSize: 17.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.blue,
//                       ),
//                     ).tr(),
//                 onPressed: () {
//                   context.pop();
//                 },
//               ),
//               CupertinoDialogAction(
//                 isDestructiveAction: true,
//                 child:
//                     Text(
//                       LocaleKeys.delete,
//                       style: TextStyle(
//                         fontSize: 17.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ).tr(),
//                 onPressed: () async {
//                   context.pop();
//                   context.pop();

//                   context.read<AuthenticationBloc>().add(DeleteAccount());
//                 },
//               ),
//             ],
//           ),
//     );
//   }
// }
