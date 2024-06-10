import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQPage extends StatelessWidget {
  final List<FAQ> faqs = [
    FAQ("What is “Open Source” software?", "Generally, Open Source software is software that can be freely accessed, used, changed, and shared (in modified or unmodified form) by anyone. Open source software is made by many people, and distributed under licenses that comply with the Open Source Definition. The internationally recognized Open Source Definition provides ten criteria that must be met for any software license, and the software distributed under that license, to be labeled “Open Source software.” Only software licensed under an OSI-approved Open Source license should be labeled “Open Source” software."),
    FAQ("Can Open Source software be used for commercial purposes?", "Absolutely. All Open Source software can be used for commercial purpose; the Open Source Definition guarantees this. You can even sell Open Source software."),
    FAQ("Can I restrict how people use an Open Source licensed program?", "No. The freedom to use the program for any purpose is part of the Open Source Definition. Open source licenses do not discriminate against fields of endeavor."),
    FAQ("What is “free software” and is it the same as “open source”?", "“Free software” and “open source software” are two terms for the same thing: software released under licenses that guarantee a certain specific set of freedoms."),
    FAQ("What is a “permissive” Open Source license?", "A “permissive” license is simply a non-copyleft open source license — one that guarantees the freedoms to use, modify, and redistribute, but that permits proprietary derivative works. See the copyleft entry for more information."),
    FAQ("What about software in the “public domain”? Is that Open Source?", "For most practical purposes, it is — sort of. This is a complicated question, so please read on. “Public domain” is a technical term in copyright law that refers to works not under copyright — either because they were never in copyright to begin with (for example, works authored by U.S. government employees, on government time and as part of their job, are automatically in the public domain), or because their copyright term has finally lapsed and they have “fallen into” the public domain."),
    FAQ("What if I do not want to distribute my program in source code form? Or what if I don’t want to distribute it in either source or binary form?", "If you don’t distribute source code, then what you are distributing cannot meaningfully be called “Open Source”. And if you don’t distribute at all, then by definition you’re not distributing source code, so you’re not distributing anything Open Source. Think of it this way: Open Source licenses are always applied to the source code — so if you’re not distributing the source, then you’re not distributing the thing to which an Open Source license applies."),
    FAQ("Which Open Source license should I choose to release my software under?", "You can choose any license from the open source licenses listed starting here: opensource.org/licenses. Most people select one from the “popular” category, but you are free to choose any listed license."),
    FAQ("How can I join an open source project?", "Most open source projects are run via online discussion forums: mailing lists, wikis, chat rooms, etc. We encourage you to find a project you care about, look at their web site to see what kinds of discussion forums they’re using, and join those forums. The usual next step is to starting filing bug reports and/or fixing bugs."),
    // Add more FAQs here
  ];

  @override
  Widget build(BuildContext context) {
    const ScreenUtilInit(
      designSize: Size(360, 690),
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(fontSize: 22.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: faqs.map((faq) => CustomExpansionTile(faq: faq)).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final FAQ faq;

  CustomExpansionTile({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: ExpansionTile(
          title: Text(
            faq.question,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(Icons.question_answer),
          trailing: const Icon(Icons.keyboard_arrow_down),
          backgroundColor: const Color.fromRGBO(255, 183, 77, 1),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                faq.answer,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ(this.question, this.answer);
}
