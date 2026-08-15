import 'package:flutter/material.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() =>
      _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState
    extends State<DeliveryAddressScreen> {

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController _addressController =
      TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController();

  // Submitted values
  String? submittedAddress;
  String? submittedPhone;

  // Submit form
  void _submitForm() {
    // Validate all fields
    if (_formKey.currentState!.validate()) {

      // Update UI after successful validation
      setState(() {
        submittedAddress =
            _addressController.text.trim();

        submittedPhone =
            _phoneController.text.trim();
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _addressController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              const Text(
                'Enter Delivery Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Please provide your delivery address and phone number.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              // Address field
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _addressController,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  hintText:
                      'Enter your complete delivery address',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 45),
                    child: Icon(Icons.location_on),
                  ),
                  border: OutlineInputBorder(),
                ),

                // Address validation
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter your delivery address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Phone field
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Enter 10 digit phone number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),

                // Phone validation
                validator: (value) {
                  final phone =
                      value?.trim() ?? '';

                  if (phone.isEmpty) {
                    return 'Please enter your phone number';
                  }

                  if (!RegExp(r'^\d{10}$')
                      .hasMatch(phone)) {
                    return 'Phone number must contain exactly 10 digits';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(
                    Icons.check_circle_outline,
                  ),
                  label: const Text(
                    'Confirm Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Confirmation summary
              if (submittedAddress != null &&
                  submittedPhone != null)
                _buildSummary(),
            ],
          ),
        ),
      ),
    );
  }

  // Summary widget
  Widget _buildSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Delivery Details Confirmed',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            const Text(
              'Delivery Address',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              submittedAddress!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              submittedPhone!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}