import 'package:flutter/material.dart';
import 'package:portfolio/constants/screen_util.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: ScreenUtility(context).height / 3),
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.mail_outline_outlined),
                        hintText: "Your email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a valid email.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 20,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.edit),
                        hintText: "What's up?",
                        // filled: true,
                        // fillColor: Colors.white,
                      ),
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a valid message.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email Sent')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          )
        ),
      ),
    );
  }
}