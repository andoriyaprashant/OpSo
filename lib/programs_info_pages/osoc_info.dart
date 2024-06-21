import 'package:flutter/material.dart';

class OSOCInfo extends StatelessWidget {
  const OSOCInfo({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Open Summer of Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'A 4-week summer programme in July, that provides Belgian based students the training, network and support necessary to transform open innovation projects into powerful real-world services.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'When & Where?',
                content: '1 July — 25 July From Monday to Thursday, 9AM to 5PM. On Mondays and Thursdays, we work in Brussels, on Tuesdays and Wednesdays we work remotely. You dont have to work on Fridays and weekends! You are off during holidays, but still paid!',
              ),
              const SizedBox(height: 20),
               _buildOutlinedBox(
                  context,
                  title: 'Can I participate in OSOC?',
                  content: 'Yes, if you meet the following requirements.\n'
                      '* For international students, check the next question\n\n'
                      'First of all, you’re a student eligible to work under a student contract for 16 full days (128 hours).\n'
                      'Secondly, you study or have experience in front- or back-end development, design (UX, graphic), communication or business modelling.\n'
                      'Thirdly, you should be able to express yourself in English.\n'
                      'Do you meet these requirements? Congratulations, you could be an OSOC student!',
                ),
              const SizedBox(height: 20),
               _buildOutlinedBox(
                  context,
                  title: 'Can I participate if I am not a Belgian citizen?',
                  content: 'Students from an EEA member state or from Switzerland are entitled to work in Belgium throughout the year under the same terms as Belgian students. EAA member state means any of the member states of the European Union, Iceland, Liechtenstein, and Norway.\n\n'
                      'Are you from a country that is not included in the above list? Then you may work in Belgium if you:\n'
                      'are registered in education with full curriculum in Belgium\n'
                      'have a valid residence permit\n'
                      'You must be able to work from 9 to 5 in the GMT+2 time zone.',
                ),
              const SizedBox(height: 20),
              Text(
                'Prizes and Rewards',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Get paid for your work! Even on holidays!',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Certificate of participation and a reference letter from the OSOC team.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedBox(BuildContext context, {required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeBox(BuildContext context, String description) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
