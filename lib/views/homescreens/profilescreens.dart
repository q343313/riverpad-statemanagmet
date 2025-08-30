

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/revierpad/managboth.dart';
import 'package:riverpadstate/revierpad/fullriverpad.dart';

class Profilescreens extends ConsumerWidget {
  const Profilescreens({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("Rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text("Revierpad"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: AppColors.textfieldlightmode,
                child: Padding(padding: EdgeInsets.all(14),
                    child: Consumer(builder: (context,ref,child){
                      final count = ref.watch(counter);
                      return Text(count.toString(),style: TextStyle(fontFamily: "bold",fontSize: 20),);
                    })),
              ),
              SizedBox(height: 20,),

              Consumer(builder: (context,ref,child){
                final swaith = ref.watch(switchtbutton);
                return SwitchListTile(
                    value: swaith,
                    title: Text("Notification",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "bold"),),
                    onChanged: (value)=>ref.read(switchtbutton.notifier).state = !swaith);
              }),
              SizedBox(height: 20,),
              Consumer(builder: (context,ref,child){
                final passwo = ref.watch(showpassword);
                final slid = ref.watch(slider);
                return Card(
                  color: Colors.blueAccent.withOpacity(slid),
                  child: TextFormField(
                    obscureText: passwo,
                    obscuringCharacter: "-",
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: (){
                              ref.read(showpassword.notifier).state  = !passwo;
                            },
                            icon: Icon(passwo?Icons.visibility_off:Icons.visibility,color: Colors.white,))
                    ),
                  ),
                );
              }),
              SizedBox(height: 20,),
              Consumer(builder: (context,ref,child){
                final slid = ref.watch(slider);
                return Slider(value: slid, onChanged: (value)=>ref.read(slider.notifier).state = value);
              })
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: (){
              ref.read(counter.notifier).state  ++ ;
            },
            backgroundColor: AppColors.textfieldlightmode,
            child: Icon(Icons.add),),
          FloatingActionButton(onPressed: (){
            ref.read(counter.notifier).state --;
          },
            backgroundColor: AppColors.textfieldlightmode,
            child: Icon(Icons.remove),)
        ],
      ),
    );;
  }
}



// class Profilescreens extends ConsumerStatefulWidget {
//   const Profilescreens({super.key});
//
//   @override
//   ConsumerState<Profilescreens> createState() => _ProfilescreensState();
// }
//
// class _ProfilescreensState extends ConsumerState<Profilescreens> {
//   @override
//   Widget build(BuildContext context) {
//
//     print("Rebuild");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Revierpad"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 38.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Card(
//                 color: AppColors.textfieldlightmode,
//                 child: Padding(padding: EdgeInsets.all(14),
//                 child: Consumer(builder: (context,ref,child){
//                   final count = ref.watch(counter);
//                   return Text(count.toString(),style: TextStyle(fontFamily: "bold",fontSize: 20),);
//                 })),
//               ),
//               SizedBox(height: 20,),
//
//               Consumer(builder: (context,ref,child){
//                 final swaith = ref.watch(switchtbutton);
//                 return SwitchListTile(
//                     value: swaith,
//                     title: Text("Notification",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "bold"),),
//                     onChanged: (value)=>ref.read(switchtbutton.notifier).state = !swaith);
//               }),
//               SizedBox(height: 20,),
//               Consumer(builder: (context,ref,child){
//                 final passwo = ref.watch(showpassword);
//                 final slid = ref.watch(slider);
//                 return Card(
//                   color: Colors.blueAccent.withOpacity(slid),
//                   child: TextFormField(
//                     obscureText: passwo,
//                     obscuringCharacter: "-",
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                             onPressed: (){
//                               ref.read(showpassword.notifier).state  = !passwo;
//                             },
//                             icon: Icon(passwo?Icons.visibility_off:Icons.visibility,color: Colors.white,))
//                     ),
//                   ),
//                 );
//               }),
//               SizedBox(height: 20,),
//               Consumer(builder: (context,ref,child){
//                 final slid = ref.watch(slider);
//                 return Slider(value: slid, onChanged: (value)=>ref.read(slider.notifier).state = value);
//               })
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: (){
//               ref.read(counter.notifier).state  ++ ;
//             },
//             backgroundColor: AppColors.textfieldlightmode,
//           child: Icon(Icons.add),),
//           FloatingActionButton(onPressed: (){
//             ref.read(counter.notifier).state --;
//           },
//             backgroundColor: AppColors.textfieldlightmode,
//             child: Icon(Icons.remove),)
//         ],
//       ),
//     );
//   }
// }


// class Profilescreens extends ConsumerStatefulWidget {
//   const Profilescreens({super.key});
//
//   @override
//   ConsumerState<Profilescreens> createState() => _ProfilescreensState();
// }
//
// class _ProfilescreensState extends ConsumerState<Profilescreens> {
//   @override
//   Widget build(BuildContext context) {
//     print("Rebuild");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile Screens"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Consumer(builder: (context,ref,child){
//               final sliderva = ref.watch(bothrevierpade);
//               return Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.black.withOpacity(sliderva.slider),
//               );
//             }),
//             SizedBox(height: 20,),
//             Consumer(builder: (context,ref,child){
//               final sliderva = ref.watch(bothrevierpade);
//               return Slider(value: sliderva.slider,
//                   onChanged: (value){
//                ref.read(bothrevierpade.notifier).state = sliderva.copyWith(slider: value);
//                   });
//             }),
//             SizedBox(height: 20,),
//             Consumer(builder: (context,ref,child){
//               final sliderva = ref.watch(bothrevierpade.select((val)=>val.showpassword));
//               print("Password rebudl");
//               return TextFormField(
//                 obscureText: sliderva,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//                   suffixIcon: IconButton(onPressed: (){
//                     ref.read(bothrevierpade.notifier).state  = ref.read(bothrevierpade.notifier).state.copyWith(showpassword: !sliderva);
//                   }, icon: Icon(sliderva?Icons.visibility:Icons.visibility_off,color: Colors.white,))
//                 ),
//               );
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
