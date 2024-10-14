import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

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
    FAQ("What is GirlScript Summer of Code?", "GirlScript Summer of Code is a three-month-long Open Source program conducted every summer by GirlScript Foundation. It aims to help beginners get started with Open Source development while encouraging diversity in technology."),
    FAQ("How can I apply for GirlScript Summer of Code?", "To apply for GirlScript Summer of Code, visit their official website during the application period and follow the instructions provided. Typically, you'll need to fill out an application form and submit any required documents."),
    FAQ("What is GitHub Campus Experts?", "GitHub Campus Experts are students who are trained to build on-campus communities that encourage more student developers to engage in open source and GitHub."),
    FAQ("How can I apply for GitHub Campus Experts?", "To apply for GitHub Campus Experts, you need to be a student and complete the application process on GitHub’s official website. This usually involves filling out an application form, providing references, and undergoing an interview."),
    FAQ("What is Google Season of Docs?", "Google Season of Docs provides a framework for technical writers and open source projects to work together towards the common goal of improving open source documentation."),
    FAQ("How can I apply for Google Season of Docs?", "To apply for Google Season of Docs, check the official website for timelines and application guidelines. You will need to submit a proposal and align with an open source organization."),
    FAQ("What is Google Summer of Code?", "Google Summer of Code is a global program focused on bringing more student developers into open source software development. Students work on a programming project with an open source organization during their break from school."),
    FAQ("How can I apply for Google Summer of Code?", "To apply for Google Summer of Code, visit the program’s official website, register, and submit a proposal to one of the participating open source organizations."),
    FAQ("What is Hacktoberfest?", "Hacktoberfest is a month-long celebration of open source software run by DigitalOcean. Participants are encouraged to contribute to open source projects and can earn limited edition swag."),
    FAQ("How can I participate in Hacktoberfest?", "To participate in Hacktoberfest, sign up on the official Hacktoberfest website, make four valid pull requests to any public repository on GitHub or GitLab during October, and follow the rules outlined on the site."),
    FAQ("What is Linux Foundation?", "The Linux Foundation supports the creation of sustainable open source ecosystems by providing financial and intellectual resources, infrastructure, services, events, and training."),
    FAQ("How can I get involved with the Linux Foundation?", "To get involved with the Linux Foundation, visit their official website, explore their various projects and initiatives, and follow the instructions to contribute or join."),
    FAQ("What is Major League Hacking Fellowship?", "The Major League Hacking (MLH) Fellowship is a 12-week internship alternative for aspiring software engineers. Participants work on open source projects under the guidance of experienced mentors."),
    FAQ("How can I apply for Major League Hacking Fellowship?", "To apply for the MLH Fellowship, visit the MLH Fellowship website, review the eligibility criteria, and complete the online application form during the application period."),
    FAQ("What is Open Summer of Code?", "Open Summer of Code is a program run by Open Knowledge Belgium, providing students the opportunity to work on open source projects during the summer."),
    FAQ("How can I apply for Open Summer of Code?", "To apply for Open Summer of Code, visit the official website, check the application deadlines, and submit your application as instructed."),
    FAQ("What is Outreachy?", "Outreachy provides internships to work in Free and Open Source Software (FOSS). Outreachy internships are open to applicants around the world, and are paid, remote, and offer a supportive community."),
    FAQ("How can I apply for Outreachy?", "To apply for Outreachy, visit the Outreachy website, review the application timeline and process, and submit your application including a contribution to an open source project."),
    FAQ("What is Redox?", "Redox is an open source, Unix-like operating system written in Rust. It aims to bring the innovations of Rust to a modern microkernel and full set of applications."),
    FAQ("How can I get involved with Redox?", "To get involved with Redox, visit the Redox OS website, explore the contribution guidelines, and start contributing to the project."),
    FAQ("What is Season of KDE?", "Season of KDE is an outreach program hosted by the KDE community. It offers a way for people to get involved with the KDE community by working on software projects."),
    FAQ("How can I apply for Season of KDE?", "To apply for Season of KDE, visit the KDE Community website, check the application deadlines, and follow the instructions to submit your application."),
    FAQ("What is Social Winter of Code?", "Social Winter of Code is a program designed to engage students and professionals with open source development during the winter months, fostering collaboration and learning."),
    FAQ("How can I apply for Social Winter of Code?", "To apply for Social Winter of Code, visit their official website during the application period and follow the instructions to submit your application."),
    FAQ("What is Summer of Bitcoin?", "Summer of Bitcoin is a global summer internship program for university students to work on Bitcoin open source projects under the guidance of experienced mentors."),
    FAQ("How can I apply for Summer of Bitcoin?", "To apply for Summer of Bitcoin, visit the official website, review the application criteria and timelines, and submit your application along with any required documents."),
  ];

  final ValueNotifier<List<FAQ>> filteredFaqs = ValueNotifier<List<FAQ>>([]);

  FAQPage() {
    // Initialize filtered FAQs with the full list initially
    filteredFaqs.value = faqs;
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      filteredFaqs.value = faqs
          .where((faq) =>
      faq.question.toLowerCase().contains(query) ||
          faq.answer.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    const ScreenUtilInit(
      designSize: Size(360, 690),
    );
    
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('FAQ', style: TextStyle(fontSize: 22.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                cursorColor: Colors.grey[800],

                decoration: InputDecoration(
                  labelText: 'Search FAQs',
                  labelStyle: TextStyle(
                    color: Colors.grey.shade800, // Default label color
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade800), // Focused border color
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
              SizedBox(height: 16.h),
              ValueListenableBuilder<List<FAQ>>(
                  valueListenable: filteredFaqs,
                  builder: (context, faqs, _) {
                    return Column(
                      children: faqs
                          .map((faq) => CustomExpansionTile(faq: faq))
                          .toList(),
                    );
                  },

              ),
            ],
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